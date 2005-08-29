"
An FTP Server.
"
Class {
	#name : #FTPServer,
	#superclass : #Object,
	#instVars : [
		'listener',
		'process',
		'properties',
		'sessions'
	],
	#classVars : [
		'Servers'
	],
	#category : 'FTP-Server'
}

{ #category : #private }
FTPServer class >> addServer: aServer [
	self servers add: aServer.
]

{ #category : #'class initialization' }
FTPServer class >> initialize [
	Smalltalk addToStartUpList: self.
	Smalltalk addToShutDownList: self.
]

{ #category : #private }
FTPServer class >> removeServer: aServer [
	self servers remove: aServer.
]

{ #category : #private }
FTPServer class >> servers [
	^ Servers ifNil: [ Servers := Set new ].
]

{ #category : #private }
FTPServer class >> shutDown [
	 self servers do: [ :each | each stop ].
]

{ #category : #'instance creation' }
FTPServer class >> start [
	^ self new  
		start;
		yourself.
]

{ #category : #'instance creation' }
FTPServer class >> startOn: aNumber [
	^ self new
		port: aNumber;
		start;
		yourself.
]

{ #category : #'instance creation' }
FTPServer class >> startOn: aNumber context: aContext [
	^ self new
		port: aNumber;
		context: aContext;
		start;
		yourself.
]

{ #category : #private }
FTPServer class >> startUp [
	self servers do: [ :each | each start ].
]

{ #category : #accessing }
FTPServer >> backlog [
	^ self propertyAt: #backlog ifAbsent: [ 10 ].
]

{ #category : #accessing }
FTPServer >> backlog: anInteger [
	self propertyAt: #backlog put: anInteger.
]

{ #category : #accessing }
FTPServer >> context [
	^ self propertyAt: #context ifAbsent: [ FTPFilesystemDirectoryContext new ].
]

{ #category : #accessing }
FTPServer >> context: aContext [
	self propertyAt: #context put: aContext.
]

{ #category : #'private-starting' }
FTPServer >> createListener [
	listener := Socket newTCP.
	listener listenOn: self port backlogSize: self backlog.
]

{ #category : #'private-starting' }
FTPServer >> createProcess [
	process := Process 
		forContext: [
			[ self serverLoop ]
				ensure: [ self destroyServer ] ]
		priority: self priority.
]

{ #category : #'private-starting' }
FTPServer >> createServer [
	self createSessions.
	self createProcess.
	self createListener.
	
]

{ #category : #'private-starting' }
FTPServer >> createSession: aSocket [
	self sessions add: (FTPSession new
		setServer: self;
		setContext: self context copy;
		setSocket: aSocket).
]

{ #category : #'private-starting' }
FTPServer >> createSessions [
	sessions := Set new.
]

{ #category : #'private-stopping' }
FTPServer >> destroyListener [
	listener destroy.
	listener := nil.
]

{ #category : #'private-stopping' }
FTPServer >> destroyProcess [
	process := nil.
]

{ #category : #'private-stopping' }
FTPServer >> destroyServer [
	self destroyProcess.
	self destroyListener.
	self destroySessions.
]

{ #category : #'private-stopping' }
FTPServer >> destroySession: aSession [
	self sessions remove: aSession.
]

{ #category : #'private-stopping' }
FTPServer >> destroySessions [
	self sessions do: [ :each | each close ].
	sessions := nil.
]

{ #category : #initialization }
FTPServer >> initialize [
	super initialize.
	properties := Dictionary new.
]

{ #category : #testing }
FTPServer >> isConnected [
	^ self listener notNil
		and: [ self listener isValid ]
		and: [ self listener isWaitingForConnection ].
]

{ #category : #testing }
FTPServer >> isLogging [
	^ true
]

{ #category : #testing }
FTPServer >> isRunning [
	^ self process notNil.
]

{ #category : #'accessing-readonly' }
FTPServer >> listener [
	^ listener
]

{ #category : #accessing }
FTPServer >> port [
	^ self propertyAt: #port ifAbsent: [ 21 ].
]

{ #category : #accessing }
FTPServer >> port: aNumber [
	self propertyAt: #port put: aNumber.
	self isRunning ifTrue: [ self restart ].
]

{ #category : #printing }
FTPServer >> printOn: aStream [
	super printOn: aStream.
	aStream space; nextPutAll: 'port: '; print: self port.
]

{ #category : #accessing }
FTPServer >> priority [
	^ self propertyAt: #priority ifAbsent: [ Processor userBackgroundPriority ].
]

{ #category : #accessing }
FTPServer >> priority: aNumber [
	self propertyAt: #priority put: aNumber.
	self isRunning ifTrue: [ process priority: aNumber ].
]

{ #category : #'accessing-readonly' }
FTPServer >> process [
	^ process
]

{ #category : #'private-properties' }
FTPServer >> properties [
	^ properties
]

{ #category : #'private-properties' }
FTPServer >> propertyAt: aSymbol [
	^ self properties at: aSymbol.
]

{ #category : #'private-properties' }
FTPServer >> propertyAt: aSymbol ifAbsent: aBlock [
	^ self properties at: aSymbol ifAbsent: aBlock.
]

{ #category : #'private-properties' }
FTPServer >> propertyAt: aSymbol put: anObject [
	^ self properties at: aSymbol put: anObject.
]

{ #category : #actions }
FTPServer >> restart [
	self stop; start.
]

{ #category : #private }
FTPServer >> serverLoop [
	[ self serverLoopBody ] repeat.
]

{ #category : #private }
FTPServer >> serverLoopBody [
	| socket |
	self isConnected
		ifFalse: [ self destroyListener; createListener ].
	socket := listener 
		waitForAcceptFor: self timeout 
		ifTimedOut: [ nil ].
	socket notNil ifTrue: [
		socket isConnected
			ifTrue: [ self createSession: socket ]
			ifFalse: [ socket destroy ] ].
	
]

{ #category : #'accessing-readonly' }
FTPServer >> sessions [
	^ sessions
]

{ #category : #actions }
FTPServer >> start [
	self isRunning 
		ifTrue: [ ^ self ].
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

{ #category : #accessing }
FTPServer >> timeout [
	^ self propertyAt: #timeout ifAbsent: [ 10 ].
]

{ #category : #accessing }
FTPServer >> timeout: anInteger [
	self propertyAt: #timeout put: anInteger.
]
