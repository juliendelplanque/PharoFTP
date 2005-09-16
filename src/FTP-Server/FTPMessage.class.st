Class {
	#name : #FTPMessage,
	#superclass : #Object,
	#category : #'FTP-Server'
}

{ #category : #printing }
FTPMessage >> log: aSession on: aStream [
	self subclassResponsibility.
]

{ #category : #printing }
FTPMessage >> writeOn: aStream [
	self writeOn: aStream ident: String new.
]

{ #category : #printing }
FTPMessage >> writeOn: aStream ident: aString [
	self subclassResponsibility.
]
