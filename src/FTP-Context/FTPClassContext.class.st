Class {
	#name : #FTPClassContext,
	#superclass : #FTPContext,
	#instVars : [
		'actualClass'
	],
	#category : 'FTP-Context'
}

{ #category : #accessing }
FTPClassContext >> actualClass [ 
	^ actualClass ifNil: [ actualClass := ProtoObject ]
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
	self session transferWith: [ :stream |
		self actualClass subclasses do: [ :each |
			stream nextPutAll: each name; crlf ].
		self actualClass selectors do: [ :each |
			stream nextPutAll: each; crlf ] ].
]

{ #category : #'accessing-dynamic' }
FTPClassContext >> subclasses [
	^ self actualClass subclasses
]

{ #category : #navigation }
FTPClassContext >> workingDirectory [
	^ String streamContents: [ :stream |
		stream nextPut: $/.
		self actualClass withAllSuperclasses allButLast reverse
			do: [ :each | stream nextPutAll: each asString ]
			separatedBy: [ stream nextPut: $/ ] ].
]
