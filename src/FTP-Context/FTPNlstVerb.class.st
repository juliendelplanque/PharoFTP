Class {
	#name : #FTPNlstVerb,
	#superclass : #FTPListingVerb,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPNlstVerb class >> verbs [
	^ Array with: 'NLST'.
]

{ #category : #accessing }
FTPNlstVerb >> padding [
	^ #( none ).
]

{ #category : #accessing }
FTPNlstVerb >> selectors [
	^ #( nameOf: ).
]
