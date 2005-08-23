"
A HELP request asks for human-readable information from the server. The server may accept this request with code 211 or 214, or reject it with code 502.
"
Class {
	#name : #FTPHelpCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command-Information'
}

{ #category : #accessing }
FTPHelpCommand class >> command [
	^ 'HELP'
]

{ #category : #processing }
FTPHelpCommand >> execute [
	self return: (FTPResponse code: 214 string: self context help).
]
