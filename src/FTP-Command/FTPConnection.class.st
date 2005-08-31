Class {
	#name : #FTPConnection,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : 'FTP-Server'
}

{ #category : #'instance-creation' }
FTPConnection class >> on: aSocket [
	^ self new
		setSocket: aSocket;
		yourself.
]

{ #category : #'instance-creation' }
FTPConnection class >> tcp [
	^ self on: Socket newTCP.
]

{ #category : #actions }
FTPConnection >> close [
	self isConnected 
		ifTrue: [ self stream close ].
]

{ #category : #testing }
FTPConnection >> isConnected [
	^ self stream isConnected.
]

{ #category : #actions }
FTPConnection >> open [
	self subclassResponsibility.
]

{ #category : #actions }
FTPConnection >> run: aBlock [
	self subclassResponsibility.
]

{ #category : #initialization }
FTPConnection >> setSocket: aSocket [
	stream := SocketStream on: aSocket.
]

{ #category : #accessing }
FTPConnection >> socket [
	^ self stream socket.
]

{ #category : #accessing }
FTPConnection >> stream [
	^ stream
]
