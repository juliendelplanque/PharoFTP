Class {
	#name : #FTPServerListener,
	#superclass : #FTPListener,
	#instVars : [
		'server'
	],
	#category : 'FTP-Server'
}

{ #category : #'instance-creation' }
FTPServerListener class >> server: aServer [
	^ self new
		setServer: aServer;
		yourself.
]

{ #category : #accessing }
FTPServerListener >> backlog [
	^ server settings backlog.
]

{ #category : #actions }
FTPServerListener >> handle: aSocket [
	server startSession: aSocket.
]

{ #category : #accessing }
FTPServerListener >> port [
	^ server settings port.
]

{ #category : #accessing }
FTPServerListener >> priority [
	^ server settings priority.
]

{ #category : #initialization }
FTPServerListener >> setServer: aServer [
	server := aServer
]

{ #category : #accessing }
FTPServerListener >> timeout [
	^ server settings timeout.
]
