Class {
	#name : #FTPFileSystemDirectory,
	#superclass : #FTPFileSystem,
	#instVars : [
		'children'
	],
	#category : 'FTP-Context'
}

{ #category : #'instance-creation' }
FTPFileSystemDirectory class >> on: aDirectory [
	^ self new
		setDirectory: aDirectory;
		yourself.
]

{ #category : #accessing }
FTPFileSystemDirectory >> children [
	^ children ifNil: [
		children := self directory entries collect: [ :each |
			(each fourth
				ifTrue: [ self directoryClass parent: self ]
				ifFalse: [ self fileClass parent: self ])
					setOwner: self directory;
					setEntry: each;
					yourself ] ].
]

{ #category : #'accessing-internal' }
FTPFileSystemDirectory >> directory [
	^ self owner directoryNamed: self name.
]

{ #category : #initialization }
FTPFileSystemDirectory >> setDirectory: aDirectory [
	self setOwner: aDirectory containingDirectory.
	self setEntry: (self owner entryAt: aDirectory localName).
]
