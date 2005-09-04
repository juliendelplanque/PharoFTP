Class {
	#name : #FTPSessionVerb,
	#superclass : #FTPVerb,
	#category : 'FTP-Verbs'
}

{ #category : #actions }
FTPSessionVerb >> return: aResponse [
	self context updateAuthentication: self request.
	super return: aResponse.
]
