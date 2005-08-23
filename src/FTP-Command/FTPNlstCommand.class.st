"
A directory is a list of files. It typically includes a name, type, size, and modification time of each file. The difference between LIST and NLST is that NLST returns a compressed form of the directory, showing only the name of each file, while LIST returns the entire directory.
"
Class {
	#name : #FTPNlstCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command-Navigation'
}

{ #category : #accessing }
FTPNlstCommand class >> command [
	^ 'NLST'
]

{ #category : #processing }
FTPNlstCommand >> execute [
	(FTPResponse code: 150)
		writeOn: self connection stream.
	self session withStreamDo: [ :stream |
		self context children do: [ :each | 
			self printChild: each on: stream.
			stream crlf ].
		stream flush ].
	self return: (FTPResponse code: 226).
]

{ #category : #printing }
FTPNlstCommand >> printChild: aContext on: aStream [
	aStream nextPutAll: aContext name.
]
