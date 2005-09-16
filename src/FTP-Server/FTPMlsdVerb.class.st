Class {
	#name : #FTPMlsdVerb,
	#superclass : #FTPModernListing,
	#category : #'FTP-Verbs'
}

{ #category : #accessing }
FTPMlsdVerb class >> verbs [
	^ Array with: 'MLSD'.
]

{ #category : #accessing }
FTPMlsdVerb >> children [
	^ (self findContext: self request argument type: #directory)
		children.
]
