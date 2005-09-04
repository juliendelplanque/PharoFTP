"
A PASS request has a parameter called a password. The client must not send a PASS request except immediately after a USER request. The server may accept PASS with code 230, meaning that permission to access files under this username has been granted; or with code 202, meaning that permission was already granted in response to USER; or with code 332, meaning that permission might be granted after an ACCT request. The server may reject PASS with code 503 if the previous request was not USER or with code 530 if this username and password are jointly unacceptable.
"
Class {
	#name : #FTPPassVerb,
	#superclass : #FTPSessionVerb,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPPassVerb class >> verbs [
	^ Array with: 'PASS'.
]

{ #category : #processing }
FTPPassVerb >> execute [
	self state password: self request argument.
	self return: (FTPResponse code: 230).
]
