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

{ #category : #actions }
FTPConnection >> close [
	" Close the connection of the receiver and free all resources. "
	 
	self isConnected
		ifTrue: [ self stream close ].
]

{ #category : #testing }
FTPConnection >> isConnected [
	^ self stream isConnected.
]

{ #category : #actions }
FTPConnection >> run: aBlock [
	aBlock ensure: [ self close ].
]

{ #category : #initialization }
FTPConnection >> setSocket: aSocket [
	self setStream: (SocketStream on: aSocket).
]

{ #category : #initialization }
FTPConnection >> setStream: aStream [
	stream := aStream.
]

{ #category : #accessing }
FTPConnection >> socket [
	^ self stream socket.
]

{ #category : #accessing }
FTPConnection >> stream [
	^ stream
]
