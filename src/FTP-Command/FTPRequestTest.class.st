Class {
	#name : #FTPRequestTest,
	#superclass : #FTPTestCase,
	#category : 'FTP-Tests'
}

{ #category : #testing }
FTPRequestTest >> testCommand [
	self assert: (FTPRequest readFrom: 'foo') command = 'foo'.
	self assert: (FTPRequest readFrom: 'Foo') command = 'foo'.
	self assert: (FTPRequest readFrom: 'FOO') command = 'foo'.
]

{ #category : #testing }
FTPRequestTest >> testNoArgument [
	self assert: (FTPRequest readFrom: 'a') command = 'a'.
	self assert: (FTPRequest readFrom: 'a') argument = ''.
]

{ #category : #testing }
FTPRequestTest >> testParseLinefeed [
	self assert: (FTPRequest readFrom: 'a b') command = 'a'.
	self assert: (FTPRequest readFrom: 'a b') argument = 'b'.
	
	self assert: (FTPRequest readFrom: 'a b' , String lf) command = 'a'.
	self assert: (FTPRequest readFrom: 'a b' , String lf) argument = 'b'.

	self assert: (FTPRequest readFrom: 'a b' , String crlf) command = 'a'.
	self assert: (FTPRequest readFrom: 'a b' , String crlf) argument = 'b'.
]
