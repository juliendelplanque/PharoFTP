"
A STAT request asks for human-readable information about the server's status. The server normally accepts this request with code 211.
"
Class {
	#name : #FTPStatCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command-Information'
}

{ #category : #accessing }
FTPStatCommand class >> command [
	^ 'STAT'
]

{ #category : #processing }
FTPStatCommand >> execute [
	self return: (FTPResponse code: 211 string: self context statistics).
]
