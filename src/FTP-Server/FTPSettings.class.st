Class {
	#name : #FTPSettings,
	#superclass : #FTPProperties,
	#category : #'FTP-Server'
}

{ #category : #server }
FTPSettings >> authenticator [
	^ self propertyAt: #authenticator ifAbsent: [ FTPBasicAuthenticator new ].
]

{ #category : #server }
FTPSettings >> authenticator: anAuthenticator [
	self propertyAt: #authenticator put: anAuthenticator.
]

{ #category : #sockets }
FTPSettings >> backlog [
	^ self propertyAt: #backlog ifAbsent: [ 10 ].
]

{ #category : #sockets }
FTPSettings >> backlog: anInteger [
	self propertyAt: #backlog put: anInteger.
]

{ #category : #server }
FTPSettings >> context [
	^ self propertyAt: #context ifAbsent: [ FTPDispatcher new ].
]

{ #category : #server }
FTPSettings >> context: aContext [
	self propertyAt: #context put: aContext.
]

{ #category : #testing }
FTPSettings >> isLogging [
	^ self logging.
]

{ #category : #server }
FTPSettings >> logging [
	^ self propertyAt: #logging ifAbsent: [ false ].
]

{ #category : #server }
FTPSettings >> logging: aBoolean [
	self propertyAt: #logging put: aBoolean.
]

{ #category : #sockets }
FTPSettings >> name [
	^ self propertyAt: #name ifAbsent: [ 'FTP' ].
]

{ #category : #sockets }
FTPSettings >> name: aString [
	" Set the name of the server process, this should be an unique value. "

	^ self propertyAt: #name put: aString.
]

{ #category : #tools }
FTPSettings >> nameFor: aString [
	^ String streamContents: [ :stream |
		stream nextPutAll: (self name ifNil: [ 'FTP' ]).
		stream nextPut: $(; nextPutAll: aString; nextPut: $) ].
]

{ #category : #sockets }
FTPSettings >> passive [
	^ self propertyAt: #passive ifAbsent: [ true ].
]

{ #category : #sockets }
FTPSettings >> passive: aBoolean [
	" Enable or disable support for passive mode of client. Most clients require passive-mode, otherwise they don't work. "

	self propertyAt: #passive put: aBoolean.
]

{ #category : #sockets }
FTPSettings >> port [
	^ self propertyAt: #port ifAbsent: [ 21 ].
]

{ #category : #sockets }
FTPSettings >> port: aNumber [
	" Set the port number the server is listening on, most FTP servers are expected to listen on port 21. "

	self propertyAt: #port put: aNumber.
]

{ #category : #sockets }
FTPSettings >> priority [
	^ self propertyAt: #priority ifAbsent: [ Processor userBackgroundPriority ].
]

{ #category : #sockets }
FTPSettings >> priority: aNumber [
	" Set the priority the server processes should run in. "

	self propertyAt: #priority put: aNumber.
]

{ #category : #sockets }
FTPSettings >> range [
	^ self propertyAt: #range ifAbsent: [ 1024 to: 65536 ].
]

{ #category : #sockets }
FTPSettings >> range: anInterval [
	" Set the range of allowed ports for passive mode. Enlarging the number of ports increases the security of the server. "

	self propertyAt: #range put: anInterval.
]

{ #category : #sockets }
FTPSettings >> timeout [
	^ self propertyAt: #timeout ifAbsent: [ 10 ].
]

{ #category : #sockets }
FTPSettings >> timeout: anInteger [
	self propertyAt: #timeout put: anInteger.
]
