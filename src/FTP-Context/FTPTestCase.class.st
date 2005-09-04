Class {
	#name : #FTPTestCase,
	#superclass : #TestCase,
	#category : 'FTP-Tests'
}

{ #category : #accessing }
FTPTestCase class >> resources [
	^ Array with: FTPResource.
]

{ #category : #comparing }
FTPTestCase >> assertStreamOutput: aBlock equals: aString [
	| stream |
	aBlock value: (stream := String new writeStream).
	self assert: stream contents = aString.
]

{ #category : #accessing }
FTPTestCase >> client [
	^ FTPResource default client.
]

{ #category : #accessing }
FTPTestCase >> server [
	^ FTPResource default server.
]
