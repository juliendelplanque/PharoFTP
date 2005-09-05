"
A STAT request asks for human-readable information about the server's status. The server normally accepts this request with code 211.
"
Class {
	#name : #FTPStatVerb,
	#superclass : #FTPInformation,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPStatVerb class >> verbs [
	^ Array with: 'STAT'.
]

{ #category : #accessing }
FTPStatVerb >> contents [
	^ self context statusString.
]

{ #category : #accessing }
FTPStatVerb >> status [
	^ 211
]
