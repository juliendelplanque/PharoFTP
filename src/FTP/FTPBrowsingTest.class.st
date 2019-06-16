Class {
	#name : #FTPBrowsingTest,
	#superclass : #FTPTestCase,
	#instVars : [
		'server',
		'client'
	],
	#category : #'FTP-Tests'
}

{ #category : #asserting }
FTPBrowsingTest >> assertResponseCode: anInteger [
	self 
		assert: self response code = anInteger
		description: 'Expected response code ' , anInteger asString , ' but got ' , self response code asString , '.'.
]

{ #category : #asserting }
FTPBrowsingTest >> assertResponseLine: aString [
	self
		assert: (self response lines anySatisfy: [ :each |
			each includesSubstring: aString ])
		description: 'Expected substring "' , aString , '" in response.'.
]

{ #category : #accessing }
FTPBrowsingTest >> client [
	^ client
]

{ #category : #'accessing-config' }
FTPBrowsingTest >> context [
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
FTPBrowsingTest >> ip [
	^ #[127 0 0 1] asSocketAddress
]

{ #category : #testing }
FTPBrowsingTest >> isClientConnected [
	^ self client notNil and: [ self client isConnected ].
]

{ #category : #testing }
FTPBrowsingTest >> isServerConnected [
	^ self server notNil and: [ self server isConnected ].
]

{ #category : #actions }
FTPBrowsingTest >> open [
	self isClientConnected
		ifTrue: [ self client close ].
	client := FTPClient openOnHost: self ip port: self port.
]

{ #category : #'accessing-config' }
FTPBrowsingTest >> port [
	^ 31415
]

{ #category : #actions }
FTPBrowsingTest >> quit [
	self client quit
]

{ #category : #accessing }
FTPBrowsingTest >> response [
	^ FTPResponse fromString: self client lastResponse readStream.
]

{ #category : #accessing }
FTPBrowsingTest >> server [
	^ server
]

{ #category : #running }
FTPBrowsingTest >> setUp [
	super setUp.
	server := FTPServer on: self port context: self context.
	server settings name: 'FTP-Test'.
	server start.
	self waitForServerToProcessRequest
]

{ #category : #running }
FTPBrowsingTest >> tearDown [
	self isClientConnected
		ifTrue: [ self client close ].
	self isServerConnected
		ifTrue: [ self server stop ].
	super tearDown
]

{ #category : #'testing-settings' }
FTPBrowsingTest >> testAscii [
	self open.
	self 
		shouldnt: [ self client ascii ]
		raise: TelnetProtocolError.
]

{ #category : #'testing-settings' }
FTPBrowsingTest >> testBinary [
	self open.
	self 
		shouldnt: [ self client binary ]
		raise: TelnetProtocolError.
]

{ #category : #'testing-navigation' }
FTPBrowsingTest >> testCwd [
	self open.
	
	self client changeDirectoryTo: 'd1'.
	self assert: self client pwd equals: '/d1'.
	
	self client changeDirectoryTo: '/d2'.
	self assert: self client pwd equals: '/d2'.

	self client changeDirectoryTo: '../d3'.
	self assert: self client pwd equals: '/d3'.

]

{ #category : #'testing-navigation' }
FTPBrowsingTest >> testList [
	self open.

	self assert: (self client getDirectory includesSubstring: 'd1').
	self assert: (self client getDirectory includesSubstring: 'd2').
	self assert: (self client getDirectory includesSubstring: 'd3').
	self assert: (self client getDirectory includesSubstring: 'f3').
]

{ #category : #'testing-navigation' }
FTPBrowsingTest >> testNlst [
	self open.
	
	self assert: (self client getFileList includesSubstring: 'd1').
	self assert: (self client getFileList includesSubstring: 'd2').
	self assert: (self client getFileList includesSubstring: 'd3').
	self assert: (self client getFileList includesSubstring: 'f3').
]

{ #category : #'testing-connection' }
FTPBrowsingTest >> testOpen [
	self open.
	self assertResponseCode: 220.
	self assertResponseLine: 'ready'.
]

{ #category : #'testing-settings' }
FTPBrowsingTest >> testPassive [
	self open.
	self 
		shouldnt: [ self client passive ]
		raise: TelnetProtocolError.
]

{ #category : #'testing-navigation' }
FTPBrowsingTest >> testPwd [
	self open.
	self assert: self client pwd equals: '/'
]

{ #category : #'testing-connection' }
FTPBrowsingTest >> testSessions [
	self assert: self server sessions isEmpty.
	self open.
	self assert: self server sessions size equals: 1.
	self client quit.
	self waitForServerToProcessRequest.
	self assert: self server sessions isEmpty
]

{ #category : #private }
FTPBrowsingTest >> waitForServerToProcessRequest [
	"Give time to the server to process what is required."
	100 milliSeconds wait
]
