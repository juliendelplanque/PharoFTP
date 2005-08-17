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
	#category : 'FTP-Server'
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

{ #category : #private }
FTPServer class >> servers [
	^ Servers ifNil: [ Servers := Set new ].
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
	FTPSession new
		setContext: self context copy;
		setConnection: (FTPConnection new
			setServer: self;
			setSocket: aSocket);
		start.
]

{ #category : #'accessing-configuration' }
FTPServer >> defaultAcceptTimeout [
	^ 10.
]

{ #category : #'accessing-configuration' }
FTPServer >> defaultBacklog [
	^ 10.
]

{ #category : #'accessing-configuration' }
FTPServer >> defaultContext [
	^ FTPFilesystemContext on: (FileDirectory default).
]

{ #category : #'accessing-configuration' }
FTPServer >> defaultPort [
	^ 21.
]

{ #category : #'accessing-configuration' }
FTPServer >> defaultPriority [
	^ Processor userBackgroundPriority.
]

{ #category : #'accessing-configuration' }
FTPServer >> defaultSessionTimeout [
	^ 320.
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
	^ self listener notNil
		and: [ self listener isValid ]
		and: [ self listener isWaitingForConnection ].
]

{ #category : #testing }
FTPServer >> isRunning [
	^ self process notNil.
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
