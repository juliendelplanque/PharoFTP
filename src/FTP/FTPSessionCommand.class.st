Class {
	#name : #FTPSessionCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command'
}

{ #category : #actions }
FTPSessionCommand >> return: aResponse [
	self context updateAuthentication: self request.
	super return: aResponse.
]
