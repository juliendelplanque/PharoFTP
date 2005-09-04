"
A CDUP request asks the server to remove the last slash, and everything following it, from the name prefix. If this produces an empty name prefix, the new name prefix is a single slash. CDUP parameters are prohibited.

The server may accept a CDUP request using code 200 or 250. (RFC 959 says that code 200 is required; but it also says that CDUP uses the same codes as CWD.) The server may reject a CDUP request using code 550.
"
Class {
	#name : #FTPCdupVerb,
	#superclass : #FTPVerb,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPCdupVerb class >> verbs [
	^ Array with: 'CDUP'.
]

{ #category : #processing }
FTPCdupVerb >> execute [
	self context hasParent
		ifFalse: [ self return: FTPResponse notFound ].
	self context: self context parent.
	self return: FTPResponse okay.
]
