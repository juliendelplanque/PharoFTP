Class {
	#name : #FTPTransferCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command'
}

{ #category : #private }
FTPTransferCommand >> cleanup: aContext [
]

{ #category : #processing }
FTPTransferCommand >> execute [
	| context |
	context := self lookup.
	self response: (FTPResponse code: 150).
	self session withStreamDo: [ :stream |
		[ self process: context on: stream ]
			ensure: [ self cleanup: context ] ].
	self return: (FTPResponse code: 226).
]

{ #category : #private }
FTPTransferCommand >> lookup [
	self subclassResponsibility.
]

{ #category : #private }
FTPTransferCommand >> process: aContext on: aStream [
	self subclassResponsibility.
]
