Class {
	#name : #FTPFilesystemContext,
	#superclass : #FTPAuthenticatedContext,
	#instVars : [
		'parent',
		'directory'
	],
	#category : 'FTP-Context'
}

{ #category : #navigation }
FTPFilesystemContext >> changeDirectoryTo: aString [
	^ self copy
		directory: (self directory on: self directory pathName , 
			self directory pathNameDelimiter asString , aString);
		parent: self;
		yourself.
]

{ #category : #navigation }
FTPFilesystemContext >> changeDirectoryToParent [
	^ self parent isNil
		ifFalse: [ self parent ]
		ifTrue: [ self ].
]

{ #category : #accessing }
FTPFilesystemContext >> directory [
	^ directory ifNil: [ directory := FileDirectory default ].
]

{ #category : #accessing }
FTPFilesystemContext >> directory: aDirectory [
	directory := aDirectory
]

{ #category : #accessing }
FTPFilesystemContext >> parent [
	^ parent
]

{ #category : #accessing }
FTPFilesystemContext >> parent: aContext [
	parent := aContext
]

{ #category : #'accessing-dynamic' }
FTPFilesystemContext >> withAllParents [
	^ self parent isNil
		ifTrue: [ OrderedCollection new ]
		ifFalse: [ 
			self parent withAllParents
				add: self directory pathParts last;
				yourself ].
]

{ #category : #navigation }
FTPFilesystemContext >> workingDirectory [
	^ String streamContents: [ :stream |
		stream nextPut: $/.
		self withAllParents
			do: [ :each | stream nextPutAll: each ]
			separatedBy: [ stream nextPut: $/ ] ].
]
