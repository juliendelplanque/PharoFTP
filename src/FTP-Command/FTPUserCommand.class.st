"
A USER request has a parameter showing a username. Subsequent pathnames are interpreted relative to this username. The server may accept USER with code 230, meaning that the client has permission to access files under that username; or with code 331 or 332, meaning that permission might be granted after a PASS request. In theory, the server may reject USER with code 530, meaning that the username is unacceptable. In practice, the server does not check the username until after a PASS request.
"
Class {
	#name : #FTPUserCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command-Session'
}

{ #category : #accessing }
FTPUserCommand class >> command [
	^ 'USER'
]

{ #category : #processing }
FTPUserCommand >> execute [
	self state username: self request argument.
	self context updateAuthentication.
	self return: (FTPResponse code: 230).
]
