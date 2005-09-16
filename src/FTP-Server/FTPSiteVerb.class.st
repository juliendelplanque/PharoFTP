"
The SITE verb allows servers to provide server-defined extensions without any risk of conflict with future IETF extensions. A SITE request has a parameter with server-defined syntax and semantics. Typically the parameter consists of a subverb, a space, and a subparameter. Of course, there is a risk of conflict between server-defined extensions.
"
Class {
	#name : #FTPSiteVerb,
	#superclass : #FTPVerb,
	#category : #'FTP-Verbs'
}

{ #category : #accessing }
FTPSiteVerb class >> verbs [
	^ Array with: 'SITE'.
]

{ #category : #processing }
FTPSiteVerb >> execute [
	| command |
	command := FTPVerb
		in: self session
		for: (FTPRequest readFrom: self request argument)
		ifAbsent: [self return: FTPResponse invalidCommand ].
	self return: command execute.
]
