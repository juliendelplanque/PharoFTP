Class {
	#name : #FTPFileSystem,
	#superclass : #FTPContext,
	#instVars : [
		'owner',
		'entry'
	],
	#category : 'FTP-Context'
}

{ #category : #accessing }
FTPFileSystem >> creation [
	^ DateAndTime fromSeconds: self entry second.
]

{ #category : #'accessing-internal' }
FTPFileSystem >> directory [
	self subclassResponsibility.
]

{ #category : #'accessing-configuration' }
FTPFileSystem >> directoryClass [
	^ FTPFileSystemDirectory
]

{ #category : #'accessing-internal' }
FTPFileSystem >> entry [
	^ entry
]

{ #category : #'accessing-configuration' }
FTPFileSystem >> fileClass [
	^ FTPFileSystemFile
]

{ #category : #accessing }
FTPFileSystem >> modification [
	^ DateAndTime fromSeconds: self entry third.
]

{ #category : #accessing }
FTPFileSystem >> name [
	^ self entry first.
]

{ #category : #'accessing-internal' }
FTPFileSystem >> owner [
	^ owner
]

{ #category : #initialization }
FTPFileSystem >> setDirectory: aDirectory [
	directory := aDirectory
]

{ #category : #initialization }
FTPFileSystem >> setEntry: anArray [
	entry := anArray
]

{ #category : #initialization }
FTPFileSystem >> setOwner: aDirectory [
	owner := aDirectory
]

{ #category : #accessing }
FTPFileSystem >> size [
	^ self entry fifth.
]

{ #category : #accessing }
FTPFileSystem >> timestamp [
	^ TimeStamp fromSeconds: self entry third.
]
