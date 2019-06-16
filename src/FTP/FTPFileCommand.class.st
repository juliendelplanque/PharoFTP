Class {
	#name : #FTPFileCommand,
	#superclass : #FTPCommand,
	#instVars : [
		'target'
	],
	#category : 'FTP-Command'
}

{ #category : #checking }
FTPFileCommand >> checkTarget: aSelector [
	(self target notNil and: [ self target perform: aSelector ])
		ifFalse: [ self return: FTPResponse notFound ].
]

{ #category : #initialization }
FTPFileCommand >> setRequest: aRequest [
	super setRequest: aRequest.
	self setTarget: (self context lookup: aRequest argument).
]

{ #category : #initialization }
FTPFileCommand >> setTarget: aContext [
	target := aContext
]

{ #category : #accessing }
FTPFileCommand >> target [
	^ target
]
