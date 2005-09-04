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
	self server destroySession: self.
	self isDataConnected
		ifTrue: [ self data close ].
	self telnet close.
	
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
	| request |
	self response: (FTPResponse code: 220 string: self context welcomeString).
	[ self telnet isConnected ] whileTrue: [
		request := FTPRequest readFrom: self telnet stream.
		self response: (self responseForRequest: request) ].
]

{ #category : #initialization }
FTPSession >> initialize [
	super initialize.
	state := FTPState new.
]

{ #category : #testing }
FTPSession >> isDataConnected [
	^ self data notNil and: [ self data isConnected ].
]

{ #category : #testing }
FTPSession >> isTelnetConnected [
	^ self telnet isConnected.
]

{ #category : #processing }
FTPSession >> performLogging: aMessage [
	self server settings isLogging
		ifFalse: [ ^ self ].
	aMessage logOn: Transcript.
	Transcript endEntry.
]

{ #category : #processing }
FTPSession >> performRequest: aRequest [ 
	| verb |
	aRequest verb isEmpty ifTrue: [ ^ nil ].
	self performLogging: aRequest.
	verb := FTPVerb
		in: self for: aRequest
		ifAbsent: [ self context unknownRequest: aRequest ].
	verb execute.
]

{ #category : #'connection-telnet' }
FTPSession >> response: aResponse [
	aResponse isNil ifTrue: [ ^ self ].
	aResponse writeOn: self telnet stream.
	self telnet stream flush.
	self performLogging: aResponse.

]

{ #category : #processing }
FTPSession >> responseForRequest: aRequest [
	^ self withEscaperDo: [
		self withSessionDo: [
			self withHandlerDo: [ 
				self performRequest: aRequest ] ] ].
]

{ #category : #'connection-telnet' }
FTPSession >> return: aResponse [
	escaper value: aResponse.
	
]

{ #category : #actions }
FTPSession >> run [
	self telnet run: [ self handlerLoop ].
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
	^ aBlock on: Error do: [ :error |
		self return: (FTPResponse 
			error: (self context isNil
				ifFalse: [ self context walkbackException: error ]
				ifTrue: [ error description ])) ].
]

{ #category : #processing }
FTPSession >> withSessionDo: aBlock [
	^ FTPCurrentSession use: self during: aBlock.
]

{ #category : #'connection-data' }
FTPSession >> withStreamDo: aBlock [
	self isDataConnected
		ifTrue: [ self data close ].
	self setData: (self state passive
		ifTrue: [ FTPPassiveConnection ]
		ifFalse: [ FTPActiveConnection ]) tcp.
	self state passive
		ifFalse: [ self data socket connectTo: self state ip port: self state port ]
		ifTrue: [ self data socket listenOn: self state port backlogSize: self server backlog ].
	self data run: [ aBlock value: self data stream ].
]
