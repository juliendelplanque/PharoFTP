"
A HELP request asks for human-readable information from the server. The server may accept this request with code 211 or 214, or reject it with code 502.
"
Class {
	#name : #FTPHelpVerb,
	#superclass : #FTPInformationVerb,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPHelpVerb class >> verbs [
	^ Array with: 'HELP'.
]

{ #category : #accessing }
FTPHelpVerb >> contents [
	^ self context helpString.
]

{ #category : #accessing }
FTPHelpVerb >> status [
	^ 214
]
