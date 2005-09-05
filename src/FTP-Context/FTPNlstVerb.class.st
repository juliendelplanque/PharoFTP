Class {
	#name : #FTPNlstVerb,
	#superclass : #FTPListing,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPNlstVerb class >> verbs [
	^ Array with: 'NLST'.
]

{ #category : #printing }
FTPNlstVerb >> printContext: aContext on: aStream [
	self printName: aContext on: aStream.
	aStream nextPutAll: String crlf.
]
