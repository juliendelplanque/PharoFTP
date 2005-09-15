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
FTPAppeVerb >> lookup [
	| context |
	context := self
		findContext: self request argument 
		type: #file new: false.
	context canAppend
		ifFalse: [ self return: FTPResponse permissionDenied ].
	^ context.
]

{ #category : #private }
FTPAppeVerb >> process: aContext on: aStream [
	aContext put: aStream startingAt: aContext size.
]
