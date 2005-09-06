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

{ #category : #'accessing-config' }
FTPResource >> context [
	^ FTPMockContext new
		name: 'root';
		children: (Array 
			with: (FTPMockContext new
				name: 'd1';
				children: (Array
					with: (FTPMockContext new
						name: 'f1';
						contents: 'foo';
						yourself)
					with: (FTPMockContext new
						name: 'f2';
						contents: 'bar';
						yourself));
				yourself)
			with: (FTPMockContext new
				name: 'd2';
				children: Array new;
				yourself)
			with: (FTPMockContext new
				name: 'd3';
				children: Array new;
				yourself));
		yourself.
]

{ #category : #'accessing-config' }
FTPResource >> ip [
	^ ByteArray with: 127 with: 0 with: 0 with: 1.
]

{ #category : #testing }
FTPResource >> isClientConnected [
	^ self client notNil and: [ self client isConnected ].
]

{ #category : #testing }
FTPResource >> isServerConnected [
	^ self server notNil and: [ self server isConnected ].
]

{ #category : #actions }
FTPResource >> open [
	client := FTPClient openOnHost: self ip port: self port.
]

{ #category : #'accessing-config' }
FTPResource >> port [
	^ 31415
]

{ #category : #actions }
FTPResource >> quit [
	self isClientConnected
		ifTrue: [ self client quit ].
]

{ #category : #accessing }
FTPResource >> server [
	^ server
]

{ #category : #running }
FTPResource >> setUp [
	server := FTPServer startOn: self port context: self context.
	server settings logging: true.
]

{ #category : #running }
FTPResource >> tearDown [
	self isClientConnected
		ifTrue: [ self client close ].
	self isServerConnected
		ifTrue: [ self server stop ].
]
