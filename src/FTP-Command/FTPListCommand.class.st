Class {
	#name : #FTPListCommand,
	#superclass : #FTPNlstCommand,
	#category : 'FTP-Command-Navigation'
}

{ #category : #accessing }
FTPListCommand class >> command [
	^ 'LIST' 
]

{ #category : #printing }
FTPListCommand >> printChild: aContext on: aStream [
	aStream nextPut: $+; nextPut: $s; print: aContext size.
	aContext isDirectoryContext
		ifTrue: [ aStream nextPutAll: ',/' ].
	aContext isFileContext
		ifTrue: [ aStream nextPutAll: ',r' ].
	aStream nextPut: Character tab.
	super printChild: aContext on: aStream.
]
