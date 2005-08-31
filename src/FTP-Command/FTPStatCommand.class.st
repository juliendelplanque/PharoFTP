"
A STAT request asks for human-readable information about the server's status. The server normally accepts this request with code 211.
"
Class {
	#name : #FTPStatCommand,
	#superclass : #FTPInformationCommand,
	#category : 'FTP-Command-Information'
}

{ #category : #accessing }
FTPStatCommand class >> command [
	^ 'STAT'
]

{ #category : #accessing }
FTPStatCommand >> contents [
	^ self context statusString.
]

{ #category : #accessing }
FTPStatCommand >> status [
	^ 211
]
