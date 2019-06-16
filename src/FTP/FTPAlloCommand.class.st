"
ALLO is obsolete. The server should accept any ALLO request with code 202.
"
Class {
	#name : #FTPAlloCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command'
}

{ #category : #accessing }
FTPAlloCommand class >> command [
	^ 'ALLO'
]

{ #category : #processing }
FTPAlloCommand >> execute [
	self return: (FTPResponse code: 202).
]
