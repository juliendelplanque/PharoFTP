"
STRU is obsolete. The server should accept STRU F (in any combination of lowercase and uppercase) with code 200, and reject all other STRU attempts with code 504.
"
Class {
	#name : #FTPStruCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command-Settings'
}

{ #category : #accessing }
FTPStruCommand class >> command [
	^ 'STRU'
]

{ #category : #processing }
FTPStruCommand >> execute [
	self session returnResponse: (self request normalized = 'F'
		ifFalse: [ FTPResponse unsupportedParameter ]
		ifTrue: [ FTPResponse okay ]).
]
