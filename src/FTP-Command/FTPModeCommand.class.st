"
MODE is obsolete. The server should accept MODE S (in any combination of lowercase and uppercase) with code 200, and reject all other MODE attempts with code 504.
"
Class {
	#name : #FTPModeCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command-Settings'
}

{ #category : #processing }
FTPModeCommand >> execute [
	self session returnResponse: (self request normalized = 'S'
		ifFalse: [ FTPResponse unsupportedParameter ]
		ifTrue: [ FTPResponse okay ]).
]
