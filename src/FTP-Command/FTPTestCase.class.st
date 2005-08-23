Class {
	#name : #FTPTestCase,
	#superclass : #TestCase,
	#category : 'FTP-Tests'
}

{ #category : #comparing }
FTPTestCase >> assertStreamOutput: aBlock equals: aString [
	| stream |
	aBlock value: (stream := String new writeStream).
	self assert: stream contents = aString.
]
