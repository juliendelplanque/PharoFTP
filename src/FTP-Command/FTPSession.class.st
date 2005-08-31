Class {
	#name : #FTPSession,
	#superclass : #Object,
	#instVars : [
		'server',
		'context',
		'state',
		'telnet',
		'data',
		'escaper'
	],
	#category : 'FTP-Server'
}

{ #category : #'instance creation' }
FTPSession class >> on: aSocket context: aContext [
	^ self new
		setSocket: aSocket;
		setContext: aContext;
		yourself.
]

{ #category : #actions }
FTPSession >> close [
	self telnet close.
	self data close.
]

{ #category : #accessing }
FTPSession >> context [
	^ context
]

{ #category : #accessing }
FTPSession >> context: aContext [
	context := aContext
]

{ #category : #'accessing-reading' }
FTPSession >> data [
	^ data
]

{ #category : #processing }
FTPSession >> handlerLoop [
	| request response |
	FTPResponse ready writeOn: self telnet stream.
	[ self telnet isConnected ] whileTrue: [
		request := FTPRequest readFrom: self telnet stream.
		request command notEmpty ifTrue: [
			self server isLogging ifTrue: [ request logOn: Transcript ].
			response := self responseForRequest: request.
			self server isLogging ifTrue: [ response logOn: Transcript ].
			response writeOn: self telnet stream ] ].
]

{ #category : #initialization }
FTPSession >> initialize [
	super initialize.
	state := FTPState new.
]

{ #category : #testing }
FTPSession >> isConnected [
	^ self connection notNil and: [ self connection isConnected ].
]

{ #category : #testing }
FTPSession >> isDataConnected [
	^ self data notNil and: [ self data isConnected ].
]

{ #category : #processing }
FTPSession >> performRequest: aRequest [
	| command |
	aRequest command isEmpty
		ifTrue: [ self returnResponse: nil ].
	command := FTPCommand 
		in: self for: aRequest
		ifAbsent: [ self context unknownRequest: aRequest ].
	command execute.
]

{ #category : #processing }
FTPSession >> responseForRequest: aRequest [
	^ self withEscaperDo: [
		self withSessionDo: [
			self withHandlerDo: [ 
				self performRequest: aRequest ] ] ].
]

{ #category : #processing }
FTPSession >> returnResponse: aResponse [
	^ escaper value: aResponse.
]

{ #category : #'accessing-reading' }
FTPSession >> server [
	^ server
]

{ #category : #initialization }
FTPSession >> setContext: aContext [
	context := aContext
]

{ #category : #initialization }
FTPSession >> setData: aConnection [
	data := aConnection
]

{ #category : #initialization }
FTPSession >> setServer: aServer [
	server := aServer
]

{ #category : #initialization }
FTPSession >> setSocket: aSocket [
	telnet := FTPPassiveConnection on: aSocket.
	telnet run: [ self handlerLoop ].
]

{ #category : #'accessing-reading' }
FTPSession >> state [
	^ state
]

{ #category : #'accessing-reading' }
FTPSession >> telnet [
	^ telnet
]

{ #category : #processing }
FTPSession >> withEscaperDo: aBlock [
	escaper := [ :value | ^ value ].
	^ aBlock value.
]

{ #category : #processing }
FTPSession >> withHandlerDo: aBlock [
	^ aBlock on: Error do: [ :err | self returnResponse: (FTPResponse error: err messageText) ].
]

{ #category : #processing }
FTPSession >> withSessionDo: aBlock [
	^ FTPCurrentSession use: self during: aBlock.
]

{ #category : #'data-connection' }
FTPSession >> withStreamDo: aBlock [
	self isDataConnected
		ifTrue: [ self data close ].
	self setData: (self state passive
		ifTrue: [ FTPPassiveConnection ]
		ifFalse: [ FTPActiveConnection ]) tcp.
	self state passive
		ifFalse: [ self data socket connectTo: self state ip port: self state port ]
		ifTrue: [ self data socket listenOn: self state port backlogSize: self server defaultBacklog ].
	self data run: [ aBlock value: self data stream ].
]
