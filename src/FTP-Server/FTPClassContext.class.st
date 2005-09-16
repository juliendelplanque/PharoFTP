Class {
	#name : #FTPClassContext,
	#superclass : #FTPSmalltalkContext,
	#instVars : [
		'children'
	],
	#category : #'FTP-Context'
}

{ #category : #accessing }
FTPClassContext >> children [
	^ children ifNil: [
		children := Array streamContents: [ :stream |
			self actualClass subclasses do: [ :each |
				stream nextPut: ((FTPClassContext parent: self)
					setActualClass: each;
					yourself) ].
			self actualClass selectors do: [ :each |
				stream nextPut: ((FTPMethodContext parent: self)
					setActualClass: self actualClass;
					setSelector: each;
					yourself) ].
			self actualClass class selectors do: [ :each |
				stream nextPut: ((FTPMethodContext parent: self)
					setActualClass: self actualClass class;
					setSelector: each;
					yourself) ] ] ].
]

{ #category : #events }
FTPClassContext >> flush [
	super flush.
	children := nil.
]

{ #category : #testing }
FTPClassContext >> isDirectory [
	^ true
]

{ #category : #accessing }
FTPClassContext >> name [
	^ self actualClass name asString.
]

{ #category : #events }
FTPClassContext >> unknownRequest: aRequest [ 
	aRequest verb = 'EVAL' ifTrue: [
		self session return: (FTPResponse
			code: 200
			string: (Compiler 
				evaluate: aRequest argument
				for: self actualClass
				logged: false) asString) ].
	super unknownRequest: aRequest.
]
