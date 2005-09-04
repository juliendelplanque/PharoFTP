Class {
	#name : #FTPAppeVerb,
	#superclass : #FTPStorVerb,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPAppeVerb class >> verbs [
	^ Array with: 'APPE'.
]

{ #category : #private }
FTPAppeVerb >> process: aContext on: aStream [
	aContext put: aStream startingAt: aContext size.
]
