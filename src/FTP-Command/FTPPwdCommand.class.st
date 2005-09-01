Class {
	#name : #FTPPwdCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command'
}

{ #category : #accessing }
FTPPwdCommand class >> command [
	^ 'PWD'
]

{ #category : #processing }
FTPPwdCommand >> execute [
	self return: (FTPResponse code: 257 line: (String streamContents: [ :stream |
		stream nextPut: $"; nextPutAll: self context pathString; nextPut: $".
		stream nextPutAll: ' is current directory' ])).
]
