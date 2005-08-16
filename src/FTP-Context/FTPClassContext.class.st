Class {
	#name : #FTPClassContext,
	#superclass : #FTPAuthenticatedContext,
	#instVars : [
		'actualClass',
		'actuaClass'
	],
	#category : 'FTP-Context'
}

{ #category : #accessing }
FTPClassContext >> actualClass [ 
	^ actualClass ifNil: [ actuaClass := ProtoObject ]
]

{ #category : #accessing }
FTPClassContext >> actualClass: aClass [
	actualClass := aClass
]

{ #category : #navigation }
FTPClassContext >> changeDirectoryTo: aString [
	^ self species new
		actualClass: (Smalltalk at: aString asSymbol);
		yourself.
]

{ #category : #navigation }
FTPClassContext >> changeDirectoryToParent [
	^ self species new
		actualClass: self actualClass superclass;
		yourself.
]

{ #category : #navigation }
FTPClassContext >> listDirectory [
	self actualClass subclasses do: [ :each |
		self session write: each name ].
	self actualClass selectors do: [ :each |
		self session write: each ].
]

{ #category : #navigation }
FTPClassContext >> workingDirectory [
	^ String streamContents: [ :stream |
		stream nextPut: $/.
		self actualClass withAllSuperclasses allButLast reverse
			do: [ :each | stream nextPutAll: each asString ]
			separatedBy: [ stream nextPut: $/ ] ].
]