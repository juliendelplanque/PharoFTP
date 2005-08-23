Class {
	#name : #FTPResponseTest,
	#superclass : #FTPTestCase,
	#category : 'FTP-Tests'
}

{ #category : #testing }
FTPResponseTest >> testCode [
	self assert: (FTPResponse code: 201) code = 201.
	self assert: (FTPResponse code: 202 description: 'FTP') code = 202.
]

{ #category : #testing }
FTPResponseTest >> testLines [
	self assert: (FTPResponse code: 201) lines = #( 'OK' ).
	self assert: (FTPResponse code: 202 description: 'FTP') lines = #( 'FTP' ).
	self assert: (FTPResponse code: 203 lines: #( 'foo' 'bar' )) lines = #( 'foo' 'bar' ).
]

{ #category : #testing }
FTPResponseTest >> testStream [
	self 
		assertStreamOutput: [ :s | (FTPResponse code: 201) writeOn: s ] 
		equals: '201 OK' , String crlf.
	self 
		assertStreamOutput: [ :s | (FTPResponse code: 202 description: 'FTP') writeOn: s ]
		equals: '202 FTP' , String crlf.
	self 
		assertStreamOutput: [ :s | (FTPResponse code: 203 lines: #( 'foo' 'bar' 'zrk' )) writeOn: s ]
		equals: '203-foo' , String crlf , '203-bar' , String crlf , '203 zrk' , String crlf.
]
