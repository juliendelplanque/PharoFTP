Class {
	#name : #FTPSessionStream,
	#superclass : #SocketStream,
	#instVars : [
		'session'
	],
	#category : #'FTP-Server'
}

{ #category : #'instance-creation' }
FTPSessionStream class >> session: aSession on: aSocket [
	^ (self on: aSocket)
		setSession: aSession;
		yourself.
]

{ #category : #initialization }
FTPSessionStream >> initialize [
	super initialize.
]

{ #category : #streaming }
FTPSessionStream >> print: anObject [
	anObject printOn: self.
]

{ #category : #actions }
FTPSessionStream >> run: aBlock [
	aBlock ensure: [ self close ].
]

{ #category : #accessing }
FTPSessionStream >> server [
	^ self session server.
]

{ #category : #accessing }
FTPSessionStream >> session [
	^ session
]

{ #category : #initialization }
FTPSessionStream >> setSession: aSession [
	session := aSession
]

{ #category : #initialization }
FTPSessionStream >> setSocket: aSocket [
	socket := aSocket
]

{ #category : #accessing }
FTPSessionStream >> settings [
	^ self server settings.
]
