Class {
	#name : #FTPClassContext,
	#superclass : #FTPAuthenticatedContext,
	#instVars : [
		'actualClass',
		'actuaClass'
	],
	#category : #'FTP-Context'
}

{ #category : #'as yet unclassified' }
FTPClassContext >> actualClass [ 
	^ actualClass ifNil: [ actuaClass := ProtoObject ]
]

{ #category : #'as yet unclassified' }
FTPClassContext >> actualClass: aClass [
	actualClass := aClass
]

{ #category : #'as yet unclassified' }
FTPClassContext >> changeToParent [
	^ self species new
		actualClass: self actualClass superclass;
		yourself.
]

{ #category : #'as yet unclassified' }
FTPClassContext >> changeWorkingDirectory: aString [
	^ self species new
		actualClass: (Smalltalk at: aString asSymbol);
		yourself.
]

{ #category : #'as yet unclassified' }
FTPClassContext >> listTo: aSession [
	self actualClass subclasses do: [ :each |
		aSession write: each name ].
	self actualClass selectors do: [ :each |
		aSession write: each ].
]

{ #category : #'as yet unclassified' }
FTPClassContext >> workingDirectory [
	^ String streamContents: [ :stream |
		stream nextPut: $/.
		self actualClass withAllSuperclasses allButLast reverse
			do: [ :each | stream nextPutAll: each asString ]
			separatedBy: [ stream nextPut: $/ ] ].
]
