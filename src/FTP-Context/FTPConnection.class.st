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

{ #category : #testing }
FTPConnection >> isConnected [
	^ self socket isValid and: [ self socket isConnected ].
]

{ #category : #testing }
FTPConnection >> isLogging [
	^ true
]

{ #category : #reading }
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
	self writeLine: (String streamContents: [ :s |
		s print: anInteger; space; nextPutAll: aString ]).
]

{ #category : #state }
FTPConnection >> statusReady [
	self status: 220 description: 'SqueakFtp ready'.
]

{ #category : #accessing }
FTPConnection >> stream [
	^ stream
]

{ #category : #writing }
FTPConnection >> writeLine: aString [
	self isLogging ifTrue: [ Transcript show: '<<'; space; show: aString; cr ].
	self stream nextPutAll: aString; nextPutAll: String crlf; flush.
]

{ #category : #writing }
FTPConnection >> writeLines: aCollection [
	aCollection do: [ :each | self writeLine: each ].
]
