Class {
	#name : #FTPBrowsingTest,
	#superclass : #FTPTestCase,
	#category : 'FTP-Testing'
}

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
	self assert: self client pwd = '/d1'.
	
	self client changeDirectoryTo: '/d2'.
	self assert: self client pwd = '/d2'.

	self client changeDirectoryTo: '../d3'.
	self assert: self client pwd = '/d3'.

]

{ #category : #'testing-navigation' }
FTPBrowsingTest >> testList [
	self open.

	self assert: (self client getDirectory includesSubString: 'd1').
	self assert: (self client getDirectory includesSubString: 'd2').
	self assert: (self client getDirectory includesSubString: 'd3').
	self assert: (self client getDirectory includesSubString: 'f3').
]

{ #category : #'testing-navigation' }
FTPBrowsingTest >> testNlst [
	self open.
	
	self assert: (self client getFileList includesSubString: 'd1').
	self assert: (self client getFileList includesSubString: 'd2').
	self assert: (self client getFileList includesSubString: 'd3').
	self assert: (self client getFileList includesSubString: 'f3').
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
	self open; assert: self client pwd = '/'.
]

{ #category : #'testing-connection' }
FTPBrowsingTest >> testSessions [
	self assert: self server sessions isEmpty.
	self open.
	self assert: self server sessions size = 1.
	self quit.
	self assert: self server sessions isEmpty.
]
