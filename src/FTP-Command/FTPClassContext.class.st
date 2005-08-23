Class {
	#name : #FTPClassContext,
	#superclass : #FTPDirectoryContext,
	#instVars : [
		'actualClass'
	],
	#category : 'FTP-Context-Image'
}

{ #category : #accessing }
FTPClassContext >> actualClass [ 
	^ actualClass ifNil: [ actualClass := ProtoObject ].
]

{ #category : #accessing }
FTPClassContext >> actualClass: aClass [
	actualClass := aClass
]

{ #category : #'accessing-dynamic' }
FTPClassContext >> children [
	^ Array streamContents: [ :stream |
		self actualClass subclasses do: [ :each |
			stream nextPut: ((FTPClassContext parent: self)
				actualClass: each;
				yourself) ].
		self actualClass selectors do: [ :each |
			stream nextPut: ((FTPMethodContext parent: self)
				actualClass: self actualClass;
				selector: each;
				yourself) ] ].
]

{ #category : #'accessing-dynamic' }
FTPClassContext >> name [
	^ self actualClass name.
]

{ #category : #'accessing-dynamic' }
FTPClassContext >> timestamp [
	^ TimeStamp now.
]

{ #category : #events }
FTPClassContext >> unknownRequest: aRequest [
	aRequest command = 'EVAL'
		ifTrue: [ self session returnResponse: (FTPResponse code: 200 string: (Compiler evaluate: aRequest argument) asString) ].
	super unknownRequest: aRequest. 
]
