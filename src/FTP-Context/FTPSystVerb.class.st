"
A SYST request asks for information about the server's operating system. The server accepts this request with code 215.
"
Class {
	#name : #FTPSystVerb,
	#superclass : #FTPInformation,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPSystVerb class >> verbs [
	^ Array with: 'SYST'.
]

{ #category : #accessing }
FTPSystVerb >> contents [
	^ self context systemString.
]

{ #category : #accessing }
FTPSystVerb >> status [
	^ 215
]
