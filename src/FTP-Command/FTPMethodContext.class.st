Class {
	#name : #FTPMethodContext,
	#superclass : #FTPFileContext,
	#instVars : [
		'actualClass',
		'selector'
	],
	#category : 'FTP-Context-Image'
}

{ #category : #accessing }
FTPMethodContext >> actualClass [
	^ actualClass
]

{ #category : #accessing }
FTPMethodContext >> actualClass: aClass [
	actualClass := aClass
]

{ #category : #accessing }
FTPMethodContext >> contents [
	^ self actualClass sourceCodeAt: self selector.
]

{ #category : #accessing }
FTPMethodContext >> contents: aString [
	self actualClass compile: aString.
]

{ #category : #'accessing-dynamic' }
FTPMethodContext >> name [
	^ '#' , self selector asString.
]

{ #category : #accessing }
FTPMethodContext >> selector [
	^ selector
]

{ #category : #accessing }
FTPMethodContext >> selector: aSelector [
	selector := aSelector
]

{ #category : #'accessing-dynamic' }
FTPMethodContext >> timestamp [
	^ VersionsBrowser timeStampFor: self selector class: self actualClass reverseOrdinal: 1.
]
