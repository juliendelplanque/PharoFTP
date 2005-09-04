"
ALLO is obsolete. The server should accept any ALLO request with code 202.
"
Class {
	#name : #FTPAlloVerb,
	#superclass : #FTPVerb,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPAlloVerb class >> verbs [
	^ Array with: 'ALLO'.
]

{ #category : #processing }
FTPAlloVerb >> execute [
	self return: (FTPResponse code: 202).
]
