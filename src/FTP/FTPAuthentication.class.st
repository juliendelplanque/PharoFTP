Class {
	#name : #FTPAuthentication,
	#superclass : #FTPVerb,
	#category : 'FTP-Verbs'
}

{ #category : #actions }
FTPAuthentication >> return: aResponse [
	self context updateAuthentication: self request.
	super return: aResponse.
]
