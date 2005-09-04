Class {
	#name : #FTPTransferVerb,
	#superclass : #FTPVerb,
	#category : 'FTP-Verbs'
}

{ #category : #private }
FTPTransferVerb >> cleanup: aContext [
]

{ #category : #processing }
FTPTransferVerb >> execute [
	| context |
	context := self lookup.
	self response: (FTPResponse code: 150).
	self session withStreamDo: [ :stream |
		[ self process: context on: stream ]
			ensure: [ self cleanup: context ] ].
	self return: (FTPResponse code: 226).
]

{ #category : #private }
FTPTransferVerb >> lookup [
	self subclassResponsibility.
]

{ #category : #private }
FTPTransferVerb >> process: aContext on: aStream [
	self subclassResponsibility.
]
