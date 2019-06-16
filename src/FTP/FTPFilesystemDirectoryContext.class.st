Class {
	#name : #FTPFilesystemDirectoryContext,
	#superclass : #FTPDirectoryContext,
	#instVars : [
		'directory',
		'children'
	],
	#category : #'FTP-Context'
}

{ #category : #accessing }
FTPFilesystemDirectoryContext >> children [
	^ children ifNil: [
		children := self directory entries collect: [ :each |
			each fourth 
				ifTrue: [
					(FTPFilesystemDirectoryContext parent: self)
						setDirectory: (self directory directoryNamed: each first);
						yourself ]
				ifFalse: [ 
					(FTPFilesystemFileContext parent: self)
						setDirectory: self directory;
						setArray: each;
						yourself ] ] ].
]

{ #category : #accessing }
FTPFilesystemDirectoryContext >> directory [
	^ directory ifNil: [ directory := FileDirectory default ].
]

{ #category : #actions }
FTPFilesystemDirectoryContext >> flush [	
	children := nil.
]

{ #category : #accessing }
FTPFilesystemDirectoryContext >> name [
	^ FileDirectory localNameFor: self directory pathName.
]

{ #category : #initialization }
FTPFilesystemDirectoryContext >> setDirectory: aDirectory [
	directory := aDirectory
]
