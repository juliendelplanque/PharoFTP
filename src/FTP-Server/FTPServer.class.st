"
An FTP Server.
"
Class {
	#name : #FTPServer,
	#superclass : #Object,
	#instVars : [
		'process',
		'port',
		'priority',
		'context',
		'listener'
	],
	#classVars : [
		'Servers'
	],
	#category : #'FTP-Server'
}

{ #category : #private }
FTPServer class >> addServer: aServer [
	self servers add: aServer.
]

{ #category : #'class initialization' }
FTPServer class >> initialize [
	Smalltalk addToStartUpList: self.
]

{ #category : #private }
FTPServer class >> removeServer: aServer [
	self servers remove: aServer.
]

{ #category : #accessing }
FTPServer class >> responseCodes [
	^#(200 'Command okay.'
	500 'Syntax error, command unrecognized. This may include errors such as command line too long.'
	501 'Syntax error in parameters or arguments.'
	202 'Command not implemented, superfluous at this site.'
	502 'Command not implemented.'
	503 'Bad sequence of commands.'
	504 'Command not implemented for that parameter.'
	110 'Restart marker reply. In this case, the text is exact and not left to the particular implementation; it must read: MARK yyyy = mmmm Where yyyy is User-process data stream marker, and mmmm server''s equivalent marker (note the spaces between markers and "=").'
	211 'System status, or system help reply.'
	212 'Directory status.'
	213 'File status.'
	214 'Help message. On how to use the server or the meaning of a particular non-standard command. This reply is useful only to the human user.'
	215 'NAME system type. Where NAME is an official system name from the list in the Assigned Numbers document.'
	120 'Service ready in nnn minutes.'

	220 'Service ready for new user.'
	221 'Service closing control connection. Logged out if appropriate.'
	421 'Service not available, closing control connection. This may be a reply to any command if the service knows it must shut down.'
	125 'Data connection already open; transfer starting.'
	225 'Data connection open; no transfer in progress.'
	425 'Can''t open data connection.'
	226 'Closing data connection. Requested file action successful (for example, file transfer or file abort).'
	426 'Connection closed; transfer aborted.'
	227 'Entering Passive Mode (h1,h2,h3,h4,p1,p2).'

	230 'User logged in, proceed.'
	530 'Not logged in.'
	331 'User name okay, need password.'
	332 'Need account for login.'
	532 'Need account for storing files.'
	150 'File status okay; about to open data connection.'
	250 'Requested file action okay, completed.'
	257 '"PATHNAME" created.'
	350 'Requested file action pending further information.'
	450 'Requested file action not taken. File unavailable (e.g., file busy).'
	550 'Requested action not taken. File unavailable (e.g., file not found, no access).'
	451 'Requested action aborted. Local error in processing.'
	551 'Requested action aborted. Page type unknown.'
	452 'Requested action not taken. Insufficient storage space in system.'
	552 'Requested file action aborted. Exceeded storage allocation (for current directory or dataset).'
	553 'Requested action not taken. File name not allowed.')

]

{ #category : #private }
FTPServer class >> servers [
	Servers isNil
		ifTrue: [ Servers := Set new ].
	^Servers
]

{ #category : #'instance creation' }
FTPServer class >> start [
	^self new 
		start;
		yourself.
]

{ #category : #'instance creation' }
FTPServer class >> start: aContext [
	^self new 
		context: aContext;
		start;
		yourself.
]

{ #category : #'instance creation' }
FTPServer class >> start: aContext port: anInteger [
	^self new 
		context: aContext;
		port: anInteger; 
		start;
		yourself.
]

{ #category : #'private-callbacks' }
FTPServer class >> startUp [
	self servers do: [ :each | each restart ].
]

{ #category : #accessing }
FTPServer >> context [
	context isNil
		ifTrue: [ context := self defaultContext ].
	^context
]

{ #category : #accessing }
FTPServer >> context: aContext [
	context := aContext.
]

{ #category : #private }
FTPServer >> createListener [
	listener := Socket newTCP.
	listener listenOn: self port backlogSize: self defaultBacklog.
]

{ #category : #private }
FTPServer >> createProcess [
	process := Process 
		forContext: [
			[ self serverLoop ]
				ensure: [ self destroyServer ] ]
		priority: self priority.
]

{ #category : #private }
FTPServer >> createServer [
	self createProcess.
	self createListener.
]

{ #category : #private }
FTPServer >> createSession: aSocket [
	FTPSession 
		start: self context copy 
		socket: aSocket
		server: self.
]

{ #category : #'accessing-configuration' }
FTPServer >> defaultAcceptTimeout [
	^10.
]

{ #category : #'accessing-configuration' }
FTPServer >> defaultBacklog [
	^10.
]

{ #category : #'accessing-configuration' }
FTPServer >> defaultContext [
	^FTPFilesystemContext on: (FileDirectory default).
]

{ #category : #'accessing-configuration' }
FTPServer >> defaultPort [
	^21.
]

{ #category : #'accessing-configuration' }
FTPServer >> defaultPriority [
	^Processor userBackgroundPriority.
]

{ #category : #'accessing-configuration' }
FTPServer >> defaultSessionTimeout [
	^320.
]

{ #category : #private }
FTPServer >> destroyListener [
	listener destroy.
	listener := nil.
]

{ #category : #private }
FTPServer >> destroyProcess [
	process := nil.
]

{ #category : #private }
FTPServer >> destroyServer [
	self destroyProcess.
	self destroyListener.
]

{ #category : #testing }
FTPServer >> isConnected [
	^self listener notNil
		and: [ self listener isValid ]
		and: [ self listener isWaitingForConnection ].
]

{ #category : #testing }
FTPServer >> isRunning [
	^self process notNil.
]

{ #category : #'accessing-readonly' }
FTPServer >> listener [
	^listener
]

{ #category : #accessing }
FTPServer >> port [
	port isNil
		ifTrue: [ port := self defaultPort ].
	^port
]

{ #category : #accessing }
FTPServer >> port: aNumber [
	port := aNumber.
	self isRunning
		ifTrue: [ self restart ].
]

{ #category : #printing }
FTPServer >> printOn: aStream [
	super printOn: aStream.
	aStream space; nextPutAll: 'port: '; print: self port.
	aStream space; nextPutAll: 'context: '; print: self context.
]

{ #category : #accessing }
FTPServer >> priority [
	priority isNil
		ifTrue: [ priority := self defaultPriority ].
	^priority
]

{ #category : #accessing }
FTPServer >> priority: aNumber [
	priority := aNumber.
	self isRunning 
		ifTrue: [ process priority: aNumber ].
]

{ #category : #'accessing-readonly' }
FTPServer >> process [
	^process
]

{ #category : #actions }
FTPServer >> restart [
	self stop; start.
]

{ #category : #private }
FTPServer >> serverLoop [
	[ self serverLoopBody ]
		repeat.
]

{ #category : #private }
FTPServer >> serverLoopBody [
	| socket |
	self isConnected
		ifFalse: [ self destroyListener; createListener ].
	socket := listener 
		waitForAcceptFor: self defaultAcceptTimeout 
		ifTimedOut: [ nil ].
	socket notNil ifTrue: [
		socket isConnected
			ifTrue: [ self createSession: socket ]
			ifFalse: [ socket destroy ] ].
	
]

{ #category : #actions }
FTPServer >> start [
	self isRunning 
		ifTrue: [ ^self ].
	self createServer.
	self process resume.
	self class addServer: self.
]

{ #category : #actions }
FTPServer >> stop [
	self isRunning 
		ifFalse: [ ^self ].
	self process terminate.
	self class removeServer: self.
]
