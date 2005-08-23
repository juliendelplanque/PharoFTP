Class {
	#name : #FTPSession,
	#superclass : #Object,
	#instVars : [
		'server',
		'context',
		'state',
		'connection',
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

{ #category : #'commands-file-transfer' }
FTPSession >> abor: aString [
	self connection errorNotImplemented.
]

{ #category : #'commands-login' }
FTPSession >> acct: aString [
	"The argument field is a Telnet string identifying the user's account. The command is not necessarily related to the USER command, as some sites may require an account for login and others only for specific access, such as storing files. In the latter case the command may arrive at any time.

	There are reply codes to differentiate these cases for the automation: when account information is required for login, the response to a successful PASSword command is reply code 332. On the other hand, if account information is NOT required for login, the reply to a successful PASSword command is 230; and if the account information is needed for  a command issued later in the dialogue, the server should return a 332 or 532 reply depending on whether it stores (pending receipt of the ACCounT command) or discards the command, respectively."
	
	self connection errorNotImplemented.
]

{ #category : #'commands-file-actions' }
FTPSession >> allo: aString [
	self connection errorNotImplemented.
]

{ #category : #'commands-file-transfer' }
FTPSession >> appe: aString [
	self connection errorNotImplemented.
]

{ #category : #'accessing-reading' }
FTPSession >> connection [
	^ connection
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

{ #category : #'commands-file-transfer' }
FTPSession >> dele: aString [
	self self connection errorNotImplemented.
]

{ #category : #processing }
FTPSession >> handlerLoop [
	| request response |
	FTPResponse ready writeOn: self connection stream.
	[ self connection isConnected ] whileTrue: [
		request := FTPRequest readFrom: self connection stream.
		request command notEmpty ifTrue: [
			self server isLogging ifTrue: [ request logOn: Transcript ].
			response := self responseForRequest: request.
			self server isLogging ifTrue: [ response logOn: Transcript ].
			response writeOn: self connection stream ] ].
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

{ #category : #'commands-file-transfer' }
FTPSession >> list: aString [
	self connection status: 150.
	self context listDirectory.
	self connection status: 226.
]

{ #category : #'commands-file-transfer' }
FTPSession >> mkd: aString [
	self connection errorUnsupportedCommand.
]

{ #category : #'commands-file-transfer' }
FTPSession >> nlst: aString [
	self list: aString.
]

{ #category : #'commands-parameters' }
FTPSession >> pasv: aString [
	aString notEmpty 
		ifTrue: [ ^ self errorInArguments ].
	self state 
		passive: true;
		ip: NetNameResolver localHostAddress;
		port: 345.
	self connection status: 227 description: (String streamContents: [ :stream |
		self state ip do: [ :each | stream print: each; nextPut: $, ].
		stream print: self state port // 256; nextPut: $,; print: self state port \\ 256 ]).
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

{ #category : #'commands-parameters' }
FTPSession >> port: aString [
	| numbers |
	numbers := aString findTokens: $,.
	(numbers size = 6 and: [ numbers allSatisfy: [ :each | each isAllDigits ] ])
		ifFalse: [ ^ self connection errorUnsupportedParameter ].
	numbers := numbers collect: [ :each | each asInteger ].
	(numbers allSatisfy: [ :each | each between: 0 and: 256 ])
		ifFalse: [ ^ self connection errorInvalidParamter ].
	self state
		passive: false;
		ip: (ByteArray
			with: numbers first with: numbers second
			with: numbers third with: numbers fourth);
		port: numbers fifth * 256 + numbers sixth.
	self connection statusOkay.
]

{ #category : #'commands-file-transfer' }
FTPSession >> pwd: aString [
	self connection status: 257 description: '"' , self context workingDirectory , '"'.
]

{ #category : #'commands-logout' }
FTPSession >> rein: aString [
	"This command terminates a USER, flushing all I/O and account information, except to allow any transfer in progress to be completed. All parameters are reset to the default settings and the control connection is left open. This is identical to the state in which a user finds himself immediately after the control connection is opened. A USER command may be expected to follow."
	
	self state: self defaultState.
	self connection statusOkay.
]

{ #category : #processing }
FTPSession >> responseForRequest: aRequest [
	^ self withEscaperDo: [
		self withSessionDo: [
			self withHandlerDo: [ 
				self performRequest: aRequest ] ] ].
]

{ #category : #'commands-file-actions' }
FTPSession >> rest: aString [
	self connection errorUnsupportedCommand.
]

{ #category : #'commands-file-actions' }
FTPSession >> retr: aString [
	self halt.
]

{ #category : #processing }
FTPSession >> returnResponse: aResponse [
	^ escaper value: aResponse.
]

{ #category : #'commands-file-transfer' }
FTPSession >> rmd: aString [
	self connection errorUnsupportedCommand.
]

{ #category : #'commands-file-transfer' }
FTPSession >> rnfr: aString [
	self connection errorUnsupportedCommand.
]

{ #category : #'commands-file-transfer' }
FTPSession >> rnto: aString [
	self connection errorUnsupportedCommand.
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
	connection := FTPPassiveConnection on: aSocket.
	connection run: [ self handlerLoop ].
]

{ #category : #'commands-login' }
FTPSession >> smnt: aString [
	"This command allows the user to mount a different file system data structure without altering his login or accounting information. Transfer parameters are similarly unchanged. The argument is a pathname specifying a directory or other system dependent file group designator."
	
	self connection errorUnsupportedCommand.
]

{ #category : #'accessing-reading' }
FTPSession >> state [
	^ state
]

{ #category : #'commands-file-actions' }
FTPSession >> stor: aString [
	self halt.
]

{ #category : #'commands-file-actions' }
FTPSession >> stou: aString [
	self connection status: 502.
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

{ #category : #processing }
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
