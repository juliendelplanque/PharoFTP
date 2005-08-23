Class {
	#name : #FTPContext,
	#superclass : #Object,
	#instVars : [
		'parent'
	],
	#category : 'FTP-Context'
}

{ #category : #'instance-creation' }
FTPContext class >> parent: aContext [
	^ self new
		setParent: aContext;
		yourself.
]

{ #category : #convenience }
FTPContext >> find: aCollection [
	self subclassResponsibility.
]

{ #category : #testing }
FTPContext >> hasParent [
	^ self parent notNil.
]

{ #category : #testing }
FTPContext >> isDirectoryContext [
	^ false
]

{ #category : #testing }
FTPContext >> isFileContext [
	^ false
]

{ #category : #convenience }
FTPContext >> lookup: aString [
	| stream name next |
	aString isEmpty 
		ifTrue: [ ^ self ].
	aString first = $/ 
		ifTrue: [ ^ self root lookup: aString allButFirst ].
	stream := aString readStream.
	name := stream upTo: $/.
	next := name = '..'
		ifTrue: [ self parent ]
		ifFalse: [ self at: name ifAbsent: nil ].
	^ next notNil 
		ifTrue: [ next lookup: stream upToEnd ].
]

{ #category : #accessing }
FTPContext >> name [
	self subclassResponsibility.
]

{ #category : #accessing }
FTPContext >> parent [
	^ parent
]

{ #category : #'accessing-dynamic' }
FTPContext >> path [
	^ self hasParent
		ifTrue: [ self parent path add: self; yourself ]
		ifFalse: [ OrderedCollection with: self ].
]

{ #category : #convenience }
FTPContext >> pathString [
	^ String streamContents: [ :stream |
		stream nextPut: $"; nextPut: $/.
		self path allButFirst
			do: [ :each | stream nextPutAll: each name ]
			separatedBy: [ stream nextPut: $/ ].
		stream nextPut: $" ].
]

{ #category : #'accessing-dynamic' }
FTPContext >> root [
	^ self hasParent
		ifTrue: [ self parent root ]
		ifFalse: [ self ].
]

{ #category : #'accessing-dynamic' }
FTPContext >> session [
	^ FTPCurrentSession value.
]

{ #category : #initialization }
FTPContext >> setParent: aContext [
	parent := aContext
]

{ #category : #accessing }
FTPContext >> size [
	self subclassResponsibility.
]

{ #category : #accessing }
FTPContext >> timestamp [
	self subclassResponsibility.
]
