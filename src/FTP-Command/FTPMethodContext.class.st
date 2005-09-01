Class {
	#name : #FTPMethodContext,
	#superclass : #FTPContext,
	#instVars : [
		'actualClass',
		'selector',
		'stamp'
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

{ #category : #'testing-permissions' }
FTPMethodContext >> isUserExecutable [
	^ self actualClass isMeta.
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

{ #category : #private }
FTPMethodContext >> stamp [
	stamp isNil ifTrue: [
		stamp := VersionsBrowser
			timeStampFor: self selector 
			class: self actualClass 
			reverseOrdinal: 1 ].
	^ stamp.
]

{ #category : #'accessing-dynamic' }
FTPMethodContext >> timestamp [
	^ [ TimeStamp fromString: (self stamp copyAfter: Character space) ]
		ifError: [ super timestamp ].
]

{ #category : #'accessing-permissions' }
FTPMethodContext >> userName [
	^ self stamp isEmpty
		ifFalse: [ self stamp copyUpTo: Character space ]
		ifTrue: [ super userName ].
]
