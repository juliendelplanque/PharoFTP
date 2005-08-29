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

{ #category : #actions }
FTPContext >> flush [
]

{ #category : #'accessing-permissions' }
FTPContext >> groupName [
	^ 'ftp'
]

{ #category : #testing }
FTPContext >> hasParent [
	^ self parent notNil.
]

{ #category : #testing }
FTPContext >> isDirectory [
	self subclassResponsibility.
]

{ #category : #testing }
FTPContext >> isFile [
	^ self isDirectory not.
]

{ #category : #'testing-permissions' }
FTPContext >> isGroupExecutable [
	^ self isUserExecutable.
]

{ #category : #'testing-permissions' }
FTPContext >> isGroupReadable [
	^ self isUserReadable.
]

{ #category : #'testing-permissions' }
FTPContext >> isGroupWriteable [
	^ self isUserWriteable.
]

{ #category : #'testing-permissions' }
FTPContext >> isOtherExecutable [
	^ self isGroupExecutable.
]

{ #category : #'testing-permissions' }
FTPContext >> isOtherReadable [
	^ self isGroupReadable.
]

{ #category : #'testing-permissions' }
FTPContext >> isOtherWriteable [
	^ self isGroupWriteable.
]

{ #category : #'testing-permissions' }
FTPContext >> isUserExecutable [
	^ self isDirectory.
]

{ #category : #'testing-permissions' }
FTPContext >> isUserReadable [
	^ true.
]

{ #category : #'testing-permissions' }
FTPContext >> isUserWriteable [
	^ self isFile.
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
		stream nextPut: $/.
		self path allButFirst
			do: [ :each | stream nextPutAll: each name ]
			separatedBy: [ stream nextPut: $/ ] ].
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
	^ 0
]

{ #category : #accessing }
FTPContext >> timestamp [
	^ TimeStamp now.
]

{ #category : #'accessing-permissions' }
FTPContext >> userName [
	^ 'ftp'
]
