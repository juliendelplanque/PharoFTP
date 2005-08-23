"
A PASS request has a parameter called a password. The client must not send a PASS request except immediately after a USER request. The server may accept PASS with code 230, meaning that permission to access files under this username has been granted; or with code 202, meaning that permission was already granted in response to USER; or with code 332, meaning that permission might be granted after an ACCT request. The server may reject PASS with code 503 if the previous request was not USER or with code 530 if this username and password are jointly unacceptable.
"
Class {
	#name : #FTPPassCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command-Session'
}

{ #category : #accessing }
FTPPassCommand class >> command [
	^ 'PASS'
]

{ #category : #processing }
FTPPassCommand >> execute [
	self state password: self request argument.
	self context updateAuthentication.
	self return: (FTPResponse code: 230).
]
