Class {
	#name : #FTPResource,
	#superclass : #TestResource,
	#instVars : [
		'server',
		'client'
	],
	#category : 'FTP-Tests'
}

{ #category : #accessing }
FTPResource >> client [
	^ client
]

{ #category : #running }
FTPResource >> connect [
	
	
]

{ #category : #'accessing-config' }
FTPResource >> ip [
	^ ByteArray with: 127 with: 0 with: 0 with: 1.
]

{ #category : #'accessing-config' }
FTPResource >> port [
	^ 31415
]

{ #category : #accessing }
FTPResource >> server [
	^ server
]

{ #category : #running }
FTPResource >> setUp [
	server := FTPServer startOn: self port.
	client := FTPClient openOnHost: self ip port: self port.
]

{ #category : #running }
FTPResource >> tearDown [
	self client isConnected
		ifTrue: [ self client close ].
	self server isConnected
		ifTrue: [ self server stop ].
]
