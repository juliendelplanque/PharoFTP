Class {
	#name : #FTPConnection,
	#superclass : #Object,
	#instVars : [
		'server',
		'socket',
		'stream'
	],
	#category : 'FTP-Server'
}

{ #category : #actions }
FTPConnection >> close [
	self stream close.
	self socket destroy.
]

{ #category : #'state-conveniance' }
FTPConnection >> error: aString [
	"The request violated some internal parsing rule in the server."

	self status: 500 description: aString.
]

{ #category : #'state-conveniance' }
FTPConnection >> errorInvalidCommand [
	"The server does not like the command."

	self status: 500 description: 'Invalid Command'.
]

{ #category : #'state-conveniance' }
FTPConnection >> errorInvalidParamter [
	"The server does not like the format of the parameter."

	self status: 501 description: 'Invalid Parameter Format'.
]

{ #category : #'state-conveniance' }
FTPConnection >> errorUnsupportedCommand [
	"The server recognized the verb but does not support it."

	self status: 502 description: 'Unsupported command'.
]

{ #category : #'state-conveniance' }
FTPConnection >> errorUnsupportedParameter [
	"The server supports the verb but does not support the parameter."
	
	self status: 504 description: 'Unsupported parameter'.
]

{ #category : #testing }
FTPConnection >> isConnected [
	^ self socket isValid and: [ self socket isConnected ].
]

{ #category : #testing }
FTPConnection >> isLogging [
	^ true
]

{ #category : #'accessing-io' }
FTPConnection >> readLine [
	| line |
	line := self stream upTo: Character lf.
	(line notEmpty and: [ line last = Character cr ])
		ifTrue: [ line := line allButLast ].
	self isLogging ifTrue: [ Transcript show: '>>'; space; show: line; cr ].
	^ line.
]

{ #category : #accessing }
FTPConnection >> server [
	^ server
]

{ #category : #initialization }
FTPConnection >> setServer: aServer [
	server := aServer.
]

{ #category : #initialization }
FTPConnection >> setSocket: aSocket [
	socket := aSocket.
	stream := SocketStream on: aSocket.
]

{ #category : #accessing }
FTPConnection >> socket [
	^ socket
]

{ #category : #state }
FTPConnection >> status: anInteger [
	self status: anInteger description: 'OK'.
]

{ #category : #state }
FTPConnection >> status: anInteger description: aString [
	self status: anInteger description: aString last: true.
]

{ #category : #state }
FTPConnection >> status: anInteger description: aString last: aBoolean [
	self writeLine: (String streamContents: [ :s |
		s print: anInteger; nextPut: (aBoolean 
			ifTrue: [ $  ]
			ifFalse: [ $- ]).
		s nextPutAll: aString ]).
]

{ #category : #state }
FTPConnection >> status: anInteger descriptions: aCollection [
	aCollection withIndexDo: [ :each :index |
		self 
			status: anInteger 
			description: each 
			last: aCollection size = index ].
]

{ #category : #'state-conveniance' }
FTPConnection >> statusOkay [
	self status: 200.
]

{ #category : #'state-conveniance' }
FTPConnection >> statusReady [
	self status: 220 description: 'SqueakFtp ready'.
]

{ #category : #accessing }
FTPConnection >> stream [
	^ stream
]

{ #category : #'accessing-io' }
FTPConnection >> writeLine: aString [
	self isLogging ifTrue: [ Transcript show: '<< '; show: aString; cr ].
	self stream nextPutAll: aString; nextPutAll: String crlf; flush.
]
