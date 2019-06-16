Class {
	#name : #FTPTestResource,
	#superclass : #TestResource,
	#instVars : [
		'server',
		'client'
	],
	#category : #'FTP-Tests'
}

{ #category : #accessing }
FTPTestResource >> client [
	^ client
]

{ #category : #'accessing-config' }
FTPTestResource >> context [
	^ FTPTestContext new
		name: 'root';
		children: (Array 
			with: (FTPTestContext new
				name: 'd1';
				children: (Array
					with: (FTPTestContext new
						name: 'f1';
						contents: 'foo';
						yourself)
					with: (FTPTestContext new
						name: 'f2';
						contents: 'bar';
						yourself));
				yourself)
			with: (FTPTestContext new
				name: 'd2';
				children: Array new;
				yourself)
			with: (FTPTestContext new
				name: 'd3';
				children: Array new;
				yourself)
			with: (FTPTestContext new
				name: 'f3';
				yourself));
		yourself.
]

{ #category : #'accessing-config' }
FTPTestResource >> ip [
	^ #[127 0 0 1] asSocketAddress
]

{ #category : #testing }
FTPTestResource >> isClientConnected [
	^ self client notNil and: [ self client isConnected ].
]

{ #category : #testing }
FTPTestResource >> isServerConnected [
	^ self server notNil and: [ self server isConnected ].
]

{ #category : #'accessing-config' }
FTPTestResource >> name [
	^ 'FTP-Test'
]

{ #category : #actions }
FTPTestResource >> open [
	
]

{ #category : #'accessing-config' }
FTPTestResource >> port [
	^ 31415
]

{ #category : #actions }
FTPTestResource >> quit [
	self isClientConnected
		ifTrue: [ self client quit ].
]

{ #category : #accessing }
FTPTestResource >> server [
	^ server
]

{ #category : #running }
FTPTestResource >> setUp [
	super setUp.
	server := FTPServer on: self port context: self context.
	server settings name: self name.
	server start.
	100 milliSeconds wait.
	client := FTPClient openOnHost: self ip port: self port.
]

{ #category : #running }
FTPTestResource >> tearDown [
	self isClientConnected
		ifTrue: [ self client close ].
	self isServerConnected
		ifTrue: [ self server stop ].
	super tearDown
]
