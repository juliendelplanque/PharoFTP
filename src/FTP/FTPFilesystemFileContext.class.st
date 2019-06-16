Class {
	#name : #FTPFilesystemFileContext,
	#superclass : #FTPFileContext,
	#instVars : [
		'directory',
		'array'
	],
	#category : #'FTP-Context'
}

{ #category : #accessing }
FTPFilesystemFileContext >> contents [
	| stream |
	stream := self directory readOnlyFileNamed: self name.
	^ [ stream upToEnd ] 
		ensure: [ stream close ].
]

{ #category : #accessing }
FTPFilesystemFileContext >> contents: aString [
	| stream |
	stream := self directory forceNewFileNamed: self name.
	[ stream nextPutAll: aString ]
		ensure: [ stream close ].
]

{ #category : #accessing }
FTPFilesystemFileContext >> name [
	^ array first
]

{ #category : #initialization }
FTPFilesystemFileContext >> setArray: anArray [
	array := anArray
]

{ #category : #initialization }
FTPFilesystemFileContext >> setDirectory: aDirectory [
	directory := aDirectory
]

{ #category : #accessing }
FTPFilesystemFileContext >> size [
	^ array fifth.
]

{ #category : #accessing }
FTPFilesystemFileContext >> timestamp [
	^ TimeStamp fromSeconds: array third.
]
