Class {
	#name : #FTPSizeCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command'
}

{ #category : #accessing }
FTPSizeCommand class >> command [
	^ 'SIZE'
]

{ #category : #processing }
FTPSizeCommand >> execute [
	| context |
	context := self findContext: self request argument.
	self return: (FTPResponse code: 213 line: context size asString).
]
