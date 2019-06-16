Class {
	#name : #FTPTestCase,
	#superclass : #TestCase,
	#category : 'FTP-Tests'
}

{ #category : #asserting }
FTPTestCase >> assertStreamOutput: aBlock equals: aString [
	| stream |
	aBlock value: (stream := String new writeStream).
	self 
		assert: stream contents = aString 
		description: aString , ' expected'.
]
