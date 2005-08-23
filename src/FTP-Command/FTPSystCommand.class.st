"
A SYST request asks for information about the server's operating system. The server accepts this request with code 215.
"
Class {
	#name : #FTPSystCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command-Information'
}

{ #category : #accessing }
FTPSystCommand class >> command [
	^ 'SYST'
]

{ #category : #processing }
FTPSystCommand >> execute [
	self return: (FTPResponse code: 215 string: self context system).
]
