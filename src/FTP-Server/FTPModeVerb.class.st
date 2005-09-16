"
MODE is obsolete. The server should accept MODE S (in any combination of lowercase and uppercase) with code 200, and reject all other MODE attempts with code 504.
"
Class {
	#name : #FTPModeVerb,
	#superclass : #FTPVerb,
	#category : #'FTP-Verbs'
}

{ #category : #accessing }
FTPModeVerb class >> verbs [
	^ Array with: 'MODE'.
]

{ #category : #processing }
FTPModeVerb >> execute [
	self response: (self request normalized = 'S'
		ifFalse: [ FTPResponse unsupportedParameter ]
		ifTrue: [ FTPResponse okay ]).
]
