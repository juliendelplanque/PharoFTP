Class {
	#name : #FTPTestCase,
	#superclass : #TestCase,
	#category : #'FTP-Testing'
}

{ #category : #accessing }
FTPTestCase class >> resources [
	^ Array with: FTPTestResource.
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
	^ self resource client.
]

{ #category : #actions }
FTPTestCase >> open [
	^ self resource open.
]

{ #category : #actions }
FTPTestCase >> quit [
	^ self resource quit.
]

{ #category : #accessing }
FTPTestCase >> resource [
	^ FTPTestResource current.
]

{ #category : #accessing }
FTPTestCase >> response [
	^ FTPResponse fromString: self client lastResponse readStream.
]

{ #category : #accessing }
FTPTestCase >> server [
	^ self resource server.
]

{ #category : #running }
FTPTestCase >> tearDown [
	self quit.
]
