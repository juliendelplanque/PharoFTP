Class {
	#name : #FTPMethodContext,
	#superclass : #FTPSmalltalkContext,
	#instVars : [
		'selector',
		'user',
		'modification',
		'creation'
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

{ #category : #accessing }
FTPMethodContext >> creation [
	^ creation ifNil: [ super creation ].
]

{ #category : #events }
FTPMethodContext >> flush [
	| version |
	super flush.
	version := VersionsBrowser new
		scanVersionsOf: self method
		class: self actualClass 
		meta: self actualClass isMeta
		category: nil 
		selector: self selector.
	version isNil ifTrue: [ ^ self ].
	user := version list first copyUpTo: Character space.
	modification := [ TimeStamp fromString: (version list first copyAfter: Character space) ]
		ifError: [ nil ].
	creation := [ TimeStamp fromString: (version list last copyAfter: Character space) ]
		ifError: [ nil ].
]

{ #category : #'testing-permissions' }
FTPMethodContext >> isUserExecutable [
	^ self actualClass isMeta.
]

{ #category : #accessing }
FTPMethodContext >> method [
	^ self actualClass compiledMethodAt: self selector ifAbsent: [ nil ].
]

{ #category : #accessing }
FTPMethodContext >> modification [
	^ modification ifNil: [ super modification ].
]

{ #category : #accessing }
FTPMethodContext >> name [
	^ self selector asString.
]

{ #category : #accessing }
FTPMethodContext >> ownerName [
	^ user ifNil: [ super ownerName ].
]

{ #category : #accessing }
FTPMethodContext >> selector [
	^ selector
]

{ #category : #initialization }
FTPMethodContext >> setSelector: aSelector [
	selector := aSelector.
	self flush.
]
