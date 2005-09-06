Class {
	#name : #FTPTestCase,
	#superclass : #TestCase,
	#category : 'FTP-Tests'
}

{ #category : #accessing }
FTPTestCase class >> resources [
	^ Array with: FTPResource.
]

{ #category : #asserting }
FTPTestCase >> assertResponseCode: anInteger [
	self 
		assert: self response code = anInteger
		description: 'Expected response code ' , anInteger asString , ' but got ' , self response code asString , '.'.
]

{ #category : #asserting }
FTPTestCase >> assertResponseLine: aString [
	self
		assert: (self response lines anySatisfy: [ :each |
			each includesSubString: aString ])
		description: 'Expected substring "' , aString , '" in response.'.
]

{ #category : #asserting }
FTPTestCase >> assertStreamOutput: aBlock equals: aString [
	| stream |
	aBlock value: (stream := String new writeStream).
	self 
		assert: stream contents = aString 
		description: aString , ' expected'.
]

{ #category : #accessing }
FTPTestCase >> client [
	^ FTPResource current client.
]

{ #category : #actions }
FTPTestCase >> open [
	FTPResource current open.
]

{ #category : #actions }
FTPTestCase >> quit [
	FTPResource current quit.
]

{ #category : #accessing }
FTPTestCase >> response [
	^ FTPResponse fromString: self client lastResponse readStream.
]

{ #category : #accessing }
FTPTestCase >> server [
	^ FTPResource current server.
]

{ #category : #running }
FTPTestCase >> tearDown [
	self quit.
]
