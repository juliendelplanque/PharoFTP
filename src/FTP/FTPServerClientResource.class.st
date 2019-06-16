Class {
	#name : #FTPServerClientResource,
	#superclass : #TestResource,
	#instVars : [
		'server',
		'client'
	],
	#category : 'FTP-Tests'
}

{ #category : #accessing }
FTPServerClientResource >> client [
	^ client
]

{ #category : #running }
FTPServerClientResource >> connect [
	
	
]

{ #category : #'accessing-config' }
FTPServerClientResource >> ip [
	^ ByteArray with: 127 with: 0 with: 0 with: 1.
]

{ #category : #'accessing-config' }
FTPServerClientResource >> port [
	^ 31415
]

{ #category : #accessing }
FTPServerClientResource >> server [
	^ server
]

{ #category : #running }
FTPServerClientResource >> setUp [
	server := FTPServer startOn: self port.
	client := FTPClient openOnHost: self ip port: self port.
]

{ #category : #running }
FTPServerClientResource >> tearDown [
	self client isConnected
		ifTrue: [ self client close ].
	self server isConnected
		ifTrue: [ self server stop ].
]
