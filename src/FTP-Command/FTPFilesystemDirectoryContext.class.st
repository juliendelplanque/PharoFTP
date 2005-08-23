Class {
	#name : #FTPFilesystemDirectoryContext,
	#superclass : #FTPDirectoryContext,
	#instVars : [
		'directory'
	],
	#category : 'FTP-Context-Filestystem'
}

{ #category : #accessing }
FTPFilesystemDirectoryContext >> children [
	^ self directory entries collect: [ :each |
		each fourth 
			ifTrue: [
				(FTPFilesystemDirectoryContext parent: self)
					setDirectory: (self directory directoryNamed: each first);
					yourself ]
			ifFalse: [ 
				(FTPFilesystemFileContext parent: self)
					setDirectory: self directory;
					setArray: each;
					yourself ] ].
]

{ #category : #accessing }
FTPFilesystemDirectoryContext >> directory [
	^ directory ifNil: [ directory := FileDirectory default ].
]

{ #category : #accessing }
FTPFilesystemDirectoryContext >> name [
	^ FileDirectory localNameFor: self directory pathName.
]

{ #category : #initialization }
FTPFilesystemDirectoryContext >> setDirectory: aDirectory [
	directory := aDirectory
]

{ #category : #accessing }
FTPFilesystemDirectoryContext >> timestamp [
	^ nil
]
