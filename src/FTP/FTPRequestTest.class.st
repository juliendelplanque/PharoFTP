Class {
	#name : #FTPRequestTest,
	#superclass : #FTPTestCase,
	#category : 'FTP-Tests'
}

{ #category : #testing }
FTPRequestTest >> testNoArgument [
	self assert: (FTPRequest readFrom: 'a' readStream) verb = 'A'.
	self assert: (FTPRequest readFrom: 'a' readStream) argument = ''.
]

{ #category : #testing }
FTPRequestTest >> testParseLinefeed [
	self assert: (FTPRequest readFrom: 'a b' readStream) verb = 'A'.
	self assert: (FTPRequest readFrom: 'a b' readStream) argument = 'b'.
	self assert: (FTPRequest readFrom: ('a b' , String lf) readStream) verb = 'A'.
	self assert: (FTPRequest readFrom: ('a b' , String lf) readStream) argument = 'b'.
	self assert: (FTPRequest readFrom: ('a b' , String crlf) readStream) verb = 'A'.
	self assert: (FTPRequest readFrom: ('a b' , String crlf) readStream) argument = 'b'
]

{ #category : #testing }
FTPRequestTest >> testVerb [
	self assert: (FTPRequest readFrom: 'foo' readStream) verb = 'FOO'.
	self assert: (FTPRequest readFrom: 'Foo' readStream) verb = 'FOO'.
	self assert: (FTPRequest readFrom: 'FOO' readStream) verb = 'FOO'
]
