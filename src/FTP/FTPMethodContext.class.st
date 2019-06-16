Class {
	#name : #FTPMethodContext,
	#superclass : #FTPSmalltalkContext,
	#instVars : [
		'selector',
		'user',
		'modification',
		'creation'
	],
	#category : #'FTP-Context'
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
	version := self method sourceCode.
	version isNil ifTrue: [ ^ self ].
	user := 'Foo user'.
	modification := DateAndTime now.
	creation := DateAndTime now
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
	^ self selector collect: [ :each | each = $: ifTrue: [ $_ ] ifFalse: [ each ] ].
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

{ #category : #accessing }
FTPMethodContext >> size [
	^ self contents size.
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
