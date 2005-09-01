Class {
	#name : #FTPMethodContext,
	#superclass : #FTPSmalltalkContext,
	#instVars : [
		'selector',
		'stamp'
	],
	#category : 'FTP-Context'
}

{ #category : #'accessing-contents' }
FTPMethodContext >> contents [
	^ self actualClass sourceCodeAt: self selector.
]

{ #category : #'accessing-contents' }
FTPMethodContext >> contents: aString [
	self actualClass compile: aString.
]

{ #category : #events }
FTPMethodContext >> flush [
	super flush.
	stamp := nil.
]

{ #category : #'testing-permissions' }
FTPMethodContext >> isUserExecutable [
	^ self actualClass isMeta.
]

{ #category : #accessing }
FTPMethodContext >> name [
	^ self selector asString.
]

{ #category : #accessing }
FTPMethodContext >> selector [
	^ selector
]

{ #category : #initialization }
FTPMethodContext >> setSelector: aSelector [
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

{ #category : #accessing }
FTPMethodContext >> timestamp [
	^ [ TimeStamp fromString: (self stamp copyAfter: Character space) ]
		ifError: [ super timestamp ].
]

{ #category : #accessing }
FTPMethodContext >> userName [
	^ self stamp isEmpty
		ifFalse: [ self stamp copyUpTo: Character space ]
		ifTrue: [ super userName ].
]
