Class {
	#name : #FTPBasicTest,
	#superclass : #FTPTestCase,
	#category : 'FTP-Tests'
}

{ #category : #'testing-settings' }
FTPBasicTest >> testAscii [
	self open.
	self 
		shouldnt: [ self client ascii ]
		raise: TelnetProtocolError.
]

{ #category : #'testing-settings' }
FTPBasicTest >> testBinary [
	self open.
	self 
		shouldnt: [ self client binary ]
		raise: TelnetProtocolError.
]

{ #category : #'testing-navigation' }
FTPBasicTest >> testCwd [
	self open.
	
	self client changeDirectoryTo: 'd1'.
	self assert: self client pwd = '/d1'.
	
	self client changeDirectoryTo: '/d2'.
	self assert: self client pwd = '/d2'.

	self client changeDirectoryTo: '../d3'.
	self assert: self client pwd = '/d3'.

]

{ #category : #'testing-navigation' }
FTPBasicTest >> testNlst [
	self open.
	
	self assert: (self client getFileList includesSubString: 'd1') 

]

{ #category : #'testing-connection' }
FTPBasicTest >> testOpen [
	self open; assertResponseCode: 220; assertResponseLine: 'ready'.
]

{ #category : #'testing-settings' }
FTPBasicTest >> testPassive [
	self open.
	self 
		shouldnt: [ self client passive ]
		raise: TelnetProtocolError.
]

{ #category : #'testing-navigation' }
FTPBasicTest >> testPwd [
	self open; assert: self client pwd = '/'.
]
