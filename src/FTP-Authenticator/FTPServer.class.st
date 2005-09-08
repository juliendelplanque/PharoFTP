"
An FTP Server.
"
Class {
	#name : #FTPServer,
	#superclass : #Object,
	#instVars : [
		'settings',
		'listener',
		'sessions'
	],
	#classVars : [
		'Servers'
	],
	#category : 'FTP-Server'
}

{ #category : #accessing }
FTPServer class >> servers [
	^ Servers ifNil: [ Servers := Set new ].
]

{ #category : #private }
FTPServer class >> shutDown [
	self servers do: [ :each | each shutDown ].
]

{ #category : #starting }
FTPServer class >> startOn: aNumber [
	^ self startOn: aNumber context: FTPDispatcher new.
]

{ #category : #starting }
FTPServer class >> startOn: aNumber context: aContext [
	| server |
	server := self new.
	server settings
		port: aNumber;
		context: aContext.
	^ server start.
]

{ #category : #initialization }
FTPServer >> initialize [
	super initialize.
	settings := FTPSettings new.
	sessions := Set new.
]

{ #category : #testing }
FTPServer >> isConnected [
	^ self listener notNil.
]

{ #category : #accessing }
FTPServer >> listener [
	^ listener
]

{ #category : #printing }
FTPServer >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' port: '; print: self settings port.
]

{ #category : #actions }
FTPServer >> restart [
	self stop; start.
]

{ #category : #accessing }
FTPServer >> sessions [
	^ sessions
]

{ #category : #accessing }
FTPServer >> settings [
	^ settings
]

{ #category : #private }
FTPServer >> shutDown [
	self sessions do: [ :each | each close ].
]

{ #category : #actions }
FTPServer >> start [
	self isConnected ifTrue: [ ^ self ].
	self startServer.
]

{ #category : #private }
FTPServer >> startServer [
	listener := FTPServerListener server: self.
	listener start.
	self class servers
		add: self.
]

{ #category : #private }
FTPServer >> startSession: aSocket [
	self sessions add: (FTPSession new
		setAuthenticator: self settings authenticator;
		setContext: self settings context;
		setSocket: aSocket;
		setServer: self;
		run).
]

{ #category : #actions }
FTPServer >> stop [
	self isConnected ifFalse: [ ^ self ].
	self stopServer; shutDown.
]

{ #category : #private }
FTPServer >> stopServer [
	listener stop.
	listener := nil.
	self class servers
		remove: self 
		ifAbsent: nil.
]

{ #category : #private }
FTPServer >> stopSession: aSession [
	self sessions remove: aSession.
]
