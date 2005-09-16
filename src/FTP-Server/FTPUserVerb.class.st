"
A USER request has a parameter showing a username. Subsequent pathnames are interpreted relative to this username. The server may accept USER with code 230, meaning that the client has permission to access files under that username; or with code 331 or 332, meaning that permission might be granted after a PASS request. In theory, the server may reject USER with code 530, meaning that the username is unacceptable. In practice, the server does not check the username until after a PASS request.
"
Class {
	#name : #FTPUserVerb,
	#superclass : #FTPAuthentication,
	#category : #'FTP-Verbs'
}

{ #category : #accessing }
FTPUserVerb class >> verbs [
	^ Array with: 'USER'.
]

{ #category : #processing }
FTPUserVerb >> execute [
	self state username: self request argument.
	self return: (FTPResponse code: 230).
]
