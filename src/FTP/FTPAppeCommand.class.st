Class {
	#name : #FTPAppeCommand,
	#superclass : #FTPStorCommand,
	#category : 'FTP-Command'
}

{ #category : #accessing }
FTPAppeCommand class >> command [
	^ 'APPE'
]

{ #category : #private }
FTPAppeCommand >> process: aContext on: aStream [
	aContext put: aStream startingAt: aContext size.
]
