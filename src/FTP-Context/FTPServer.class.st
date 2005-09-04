"
An FTP Server.
"
Class {
	#name : #FTPServer,
	#superclass : #Object,
	#instVars : [
		'settings',
		'listener',
		'process',
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
FTPServer class >> startOn: aNumber [
	^ self startOn: aNumber context: FTPDispatcher new.
]

{ #category : #'instance creation' }
FTPServer class >> startOn: aNumber context: aContext [
	| server |
	server := self new.
	server settings
		port: aNumber;
		context: aContext.
	^ server start.
]

{ #category : #private }
FTPServer class >> startUp [
	self servers do: [ :each | each start ].
]

{ #category : #'private-starting' }
FTPServer >> createListener [
	listener := Socket newTCP.
	listener 
		listenOn: self settings port 
		backlogSize: self settings backlog.
]

{ #category : #'private-starting' }
FTPServer >> createProcess [
	process := Process 
		forContext: [
			[ self serverLoop ]
				ensure: [ self destroyServer ] ]
		priority: self settings priority.
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
		setContext: self settings context copy;
		setSocket: aSocket;
		setServer: self;
		run).
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
	settings := FTPSettings new.
]

{ #category : #testing }
FTPServer >> isConnected [
	^ self listener notNil
		and: [ self listener isValid ]
		and: [ self listener isWaitingForConnection ].
]

{ #category : #testing }
FTPServer >> isRunning [
	^ self process notNil.
]

{ #category : #accessing }
FTPServer >> listener [
	^ listener
]

{ #category : #printing }
FTPServer >> printOn: aStream [
	super printOn: aStream.
	aStream space; nextPutAll: 'port: '; print: self settings port.
]

{ #category : #accessing }
FTPServer >> process [
	^ process
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
		waitForAcceptFor: self settings timeout 
		ifTimedOut: [ nil ].
	socket notNil ifTrue: [
		socket isConnected
			ifTrue: [ self createSession: socket ]
			ifFalse: [ socket destroy ] ].
	
]

{ #category : #accessing }
FTPServer >> sessions [
	^ sessions
]

{ #category : #accessing }
FTPServer >> settings [
	^ settings
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
