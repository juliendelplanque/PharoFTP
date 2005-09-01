"
The SITE verb allows servers to provide server-defined extensions without any risk of conflict with future IETF extensions. A SITE request has a parameter with server-defined syntax and semantics. Typically the parameter consists of a subverb, a space, and a subparameter. Of course, there is a risk of conflict between server-defined extensions.
"
Class {
	#name : #FTPSiteCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command'
}

{ #category : #accessing }
FTPSiteCommand class >> command [
	^ 'SITE'
]

{ #category : #processing }
FTPSiteCommand >> execute [
	| command |
	command := FTPCommand 
		in: self session
		for: (FTPRequest readFrom: self request argument)
		ifAbsent: [self return: FTPResponse invalidCommand ].
	command execute.
]
