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
	self assert: (FTPRequest readFrom: 'a') verb = 'A'.
	self assert: (FTPRequest readFrom: 'a') argument = ''.
]

{ #category : #testing }
FTPRequestTest >> testParseLinefeed [
	self assert: (FTPRequest readFrom: 'a b') verb = 'A'.
	self assert: (FTPRequest readFrom: 'a b') argument = 'b'.
	self assert: (FTPRequest readFrom: 'a b' , String lf) verb = 'A'.
	self assert: (FTPRequest readFrom: 'a b' , String lf) argument = 'b'.
	self assert: (FTPRequest readFrom: 'a b' , String crlf) verb = 'A'.
	self assert: (FTPRequest readFrom: 'a b' , String crlf) argument = 'b'
]

{ #category : #testing }
FTPRequestTest >> testVerb [
	self assert: (FTPRequest readFrom: 'foo') verb = 'FOO'.
	self assert: (FTPRequest readFrom: 'Foo') verb = 'FOO'.
	self assert: (FTPRequest readFrom: 'FOO') verb = 'FOO'
]
