Class {
	#name : #FTPPwdVerb,
	#superclass : #FTPVerb,
	#category : #'FTP-Verbs'
}

{ #category : #accessing }
FTPPwdVerb class >> verbs [
	^ Array with: 'PWD' with: 'XPWD'.
]

{ #category : #processing }
FTPPwdVerb >> execute [
	self return: (FTPResponse code: 257 line: (String streamContents: [ :stream |
		stream nextPut: $"; nextPutAll: self context pathString; nextPut: $".
		stream nextPutAll: ' is current directory' ])).
]
