Class {
	#name : #FTPPwdCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command-Navigation'
}

{ #category : #accessing }
FTPPwdCommand class >> command [
	^ 'PWD'
]

{ #category : #processing }
FTPPwdCommand >> execute [
	self return: (FTPResponse code: 257 line: self context pathString).
]
