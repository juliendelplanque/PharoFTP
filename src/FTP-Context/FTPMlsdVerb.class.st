Class {
	#name : #FTPMlsdVerb,
	#superclass : #FTPMlstVerb,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPMlsdVerb class >> verbs [
	^ Array with: 'MLSD'.
]

{ #category : #accessing }
FTPMlsdVerb >> children [
	^ Array with: self context.
]
