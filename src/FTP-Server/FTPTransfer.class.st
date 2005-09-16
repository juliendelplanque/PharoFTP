Class {
	#name : #FTPTransfer,
	#superclass : #FTPVerb,
	#category : #'FTP-Verbs'
}

{ #category : #private }
FTPTransfer >> cleanup: aContext [
]

{ #category : #processing }
FTPTransfer >> execute [
	| context |
	context := self lookup.
	self response: (FTPResponse code: 150).
	self session withStreamDo: [ :stream |
		[ self process: context on: stream ]
			ensure: [ self cleanup: context ] ].
	self return: (FTPResponse code: 226).
]

{ #category : #private }
FTPTransfer >> lookup [
	self subclassResponsibility.
]

{ #category : #private }
FTPTransfer >> process: aContext on: aStream [
	self subclassResponsibility.
]
