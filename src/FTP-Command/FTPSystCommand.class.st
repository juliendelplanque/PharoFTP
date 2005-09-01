"
A SYST request asks for information about the server's operating system. The server accepts this request with code 215.
"
Class {
	#name : #FTPSystCommand,
	#superclass : #FTPInformationCommand,
	#category : 'FTP-Command'
}

{ #category : #accessing }
FTPSystCommand class >> command [
	^ 'SYST'
]

{ #category : #accessing }
FTPSystCommand >> contents [
	^ self context systemString.
]

{ #category : #accessing }
FTPSystCommand >> status [
	^ 215
]
