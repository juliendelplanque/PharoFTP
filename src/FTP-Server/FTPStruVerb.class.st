"
STRU is obsolete. The server should accept STRU F (in any combination of lowercase and uppercase) with code 200, and reject all other STRU attempts with code 504.
"
Class {
	#name : #FTPStruVerb,
	#superclass : #FTPVerb,
	#category : #'FTP-Verbs'
}

{ #category : #accessing }
FTPStruVerb class >> verbs [
	^ Array with: 'STRU'.
]

{ #category : #processing }
FTPStruVerb >> execute [
	self return: (self request normalized = 'F'
		ifFalse: [ FTPResponse unsupportedParameter ]
		ifTrue: [ FTPResponse okay ]).
]
