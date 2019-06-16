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

{ #category : #comparing }
FTPContext >> = anObject [
	^ self species = anObject species
		and: [ self name = anObject name ].
]

{ #category : #converting }
FTPContext >> asRenamed: aString [
	^ (FTPRenamedContext on: self)
		name: aString;
		yourself.
]

{ #category : #convenience }
FTPContext >> at: aString ifAbsent: aBlock [
	self isDirectory
		ifFalse: [ self shouldNotImplement ].
	^ self children 
		detect: [ :each | each name = aString ]
		ifNone: aBlock.
]

{ #category : #'testing-permissions' }
FTPContext >> canAppend [
	" Return true if data can be appended to the receiver. "

	^ self canWrite.
]

{ #category : #'testing-permissions' }
FTPContext >> canBeDeleted [
	" Return true if the receiver can be deleted. "

	^ self hasParent.
]

{ #category : #'testing-permissions' }
FTPContext >> canBeListed [
	" Return true if the receiver can be browsed. "

	^ self isDirectory.
]

{ #category : #'testing-permissions' }
FTPContext >> canBeRenamed [
	" Return true if the receiver can be renamed. "

	^ self hasParent.
]

{ #category : #'testing-permissions' }
FTPContext >> canCreate [
	" Return true if a file or directory can be created within the receiver. "

	^ self isDirectory.
]

{ #category : #'testing-permissions' }
FTPContext >> canRead [
	" Return true if the receiver can be read. "

	^ self isFile.
]

{ #category : #'testing-permissions' }
FTPContext >> canWrite [
	" Return true if the receiver can be written. "

	^ self isFile.
]

{ #category : #accessing }
FTPContext >> children [
	" Return a collection of children of the receiver, or nil if this is supposed to be a file. "

	^ nil
]

{ #category : #'accessing-contents' }
FTPContext >> contents [
	" Return the contents of the receiver, for non-optimized cases override this method, else have a look at #get:startingAt:. "

	^ String new.
]

{ #category : #'accessing-contents' }
FTPContext >> contents: aString [
	" Set the content of the receiver, for non-optimized cases override this method, else have a look at #put:startingAt:. "
]

{ #category : #convenience }
FTPContext >> createDirectoryNamed: aString [
	self session return: FTPResponse permissionDenied.
]

{ #category : #convenience }
FTPContext >> createFileNamed: aString [
	self session return: FTPResponse permissionDenied.
]

{ #category : #accessing }
FTPContext >> creation [
	" Return the creation-timestamp of the receiver. "

	^ DateAndTime now.
]

{ #category : #convenience }
FTPContext >> find: aCollection [
	aCollection isEmpty ifTrue: [ ^ self ].
	self isFile ifTrue: [ ^ nil ].
	^ (self at: aCollection first ifAbsent: [ ^ nil ])
		find: aCollection allButFirst.
]

{ #category : #events }
FTPContext >> flush [
	" Tells the receiver to flush any cached state, such as children. "
]

{ #category : #streaming }
FTPContext >> get: aWriteStream [
	self get: aWriteStream startingAt: 0.
]

{ #category : #streaming }
FTPContext >> get: aWriteStream startingAt: anInteger [
	aWriteStream nextPutAll: (self contents readStream 
		position: anInteger; 
		upToEnd).
]

{ #category : #'accessing-strings' }
FTPContext >> goodbyeString [
	" Return a goodbye string to be displayed when the session is quit. "

	^ 'Bye'
]

{ #category : #'accessing-strings' }
FTPContext >> groupName [
	" Return the name of the group owning the receiver. "
	
	^ 'ftp'
]

{ #category : #testing }
FTPContext >> hasParent [
	^ self parent notNil.
]

{ #category : #comparing }
FTPContext >> hash [
	^ self species hash bitXor: self name hash.
]

{ #category : #'accessing-strings' }
FTPContext >> helpString [
	" Return a help text of the current context, defaults to a human readable list of possible commands. "

	| commands |
	commands := Array streamContents: [ :stream | 
		FTPVerb withAllSubclassesDo: [ :each | 
			stream nextPutAll: each verbs ] ].
	^ String streamContents: [ :stream | 
		stream nextPutAll: 'The following commands are recognized:'; cr.
		commands sort withIndexDo: [ :each :index | 
			stream nextPutAll: (each padRightTo: 8 with: Character space).
			index \\ 7 == 0 ifTrue: [ stream cr ] ].
		stream cr; nextPutAll: 'END' ].
]

{ #category : #testing }
FTPContext >> isDirectory [
	^ self children notNil.
]

{ #category : #testing }
FTPContext >> isFile [
	^ self children isNil.
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
	((aString isEmpty or: [ aString = '.' ]) or: [ aString = '-a' ])
		ifTrue: [ ^ self ].
	aString first = $/
		ifTrue: [ ^ self root lookup: aString allButFirst ].
	stream := aString readStream.
	name := stream upTo: $/.
	next := name = '..'
		ifTrue: [ self parent ]
		ifFalse: [ self at: name ifAbsent: nil ].
	^ next isNotNil 
		ifTrue: [ next lookup: stream upToEnd ].
]

{ #category : #accessing }
FTPContext >> modification [
	" Return the modification-timestamp of the receiver. "

	^ DateAndTime now.
]

{ #category : #accessing }
FTPContext >> name [
	" Return the file-name/label of the receiver. "
	
	^ self printString.
]

{ #category : #'accessing-strings' }
FTPContext >> ownerName [
	" Return the name of the user owning the receiver. "
	
	^ 'ftp'
]

{ #category : #accessing }
FTPContext >> parent [
	" Return the parent of the reciever. "

	^ parent
]

{ #category : #accessing }
FTPContext >> path [
	" Return the context stack from the root up and including the receiver. "
	
	^ self hasParent
		ifFalse: [ OrderedCollection with: self ]
		ifTrue: [ self parent path add: self; yourself ].
]

{ #category : #'accessing-strings' }
FTPContext >> pathString [
	" Return the path of the receiver as a string. "

	^ String streamContents: [ :stream |
		stream nextPut: $/.
		self path allButFirst
			do: [ :each | stream nextPutAll: each name ]
			separatedBy: [ stream nextPut: $/ ] ].
]

{ #category : #streaming }
FTPContext >> put: aReadStream [
	^ self put: aReadStream startingAt: 0.
]

{ #category : #streaming }
FTPContext >> put: aReadStream startingAt: anInteger [
	anInteger == 1
		ifTrue: [ self contents: aReadStream upToEnd ]
		ifFalse: [
			self contents: (String streamContents: [ :stream |
				stream nextPutAll: (self contents readStream next: anInteger).
				stream nextPutAll: aReadStream upToEnd ]) ].
]

{ #category : #accessing }
FTPContext >> references [
	" Return the number of references pointing to the receiver. "
	
	^ 1
]

{ #category : #accessing }
FTPContext >> root [
	" Return the root context in the receiver's stack. "

	^ self hasParent
		ifFalse: [ self ]
		ifTrue: [ self parent root ].
]

{ #category : #accessing }
FTPContext >> session [
	" Return the current session or nil. "

	^ FTPCurrentSession value.
]

{ #category : #initialization }
FTPContext >> setParent: aContext [
	parent := aContext
]

{ #category : #accessing }
FTPContext >> size [
	" Return the size in bytes of the receiver. "
	
	^ 0
]

{ #category : #'accessing-strings' }
FTPContext >> statusString [
	" Return the status of the server, defaults to a human readable list of status values. "
	
	| state |
	state := self session state.
	^ String streamContents: [ :stream |
		state account isEmpty 
			ifFalse: [ stream nextPutAll: 'Account: '; nextPutAll: state account; cr ].
		state username isEmpty 
			ifFalse: [ stream nextPutAll: 'Username: '; nextPutAll: state username; cr ].
		stream nextPutAll: 'Type: '; nextPutAll: (state isBinary
			ifTrue: [ 'binary' ] ifFalse: [ 'ascii' ]); cr.
		stream nextPutAll: 'Transfer: '; nextPutAll: (state isPassive
			ifTrue: [ 'passive' ] ifFalse: [ 'active' ]); cr ].
]

{ #category : #'accessing-strings' }
FTPContext >> systemString [
	" Return the system name of name of the server, defaults to a human readable string. "
	
	^ SmalltalkImage current vmVersion.
]

{ #category : #accessing }
FTPContext >> timestamp [
	" Return a timestamp of the receiver. "

	^ TimeStamp now.
]

{ #category : #events }
FTPContext >> unknownRequest: aRequest [
	" This message will be sent for any unknown command, sublcasses might override the default implementation to handle additional user defined commands. "

	self session return: FTPResponse invalidCommand.
]

{ #category : #events }
FTPContext >> updateAuthentication: aRequest [
	" This message will be sent whenever a new username or password is given. "
]

{ #category : #'accessing-strings' }
FTPContext >> userName [
	" Return the name of the user owning the receiver. "
	
	^ 'ftp'
]

{ #category : #events }
FTPContext >> walkbackException: anException [
	" This message is called whenever an unexpected situation occurs. The default implementation returns a stack trace of the context where anException occured. "

	| context |
	^ String streamContents: [ :stream |
		stream nextPutAll: anException description; cr.
		context := anException signalerContext.
		[ context notNil ] whileTrue: [
			stream nextPutAll: context fullPrintString; cr.
			context := context sender ] ].
]

{ #category : #'accessing-strings' }
FTPContext >> welcomeString [
	" Return a welcome string to be displayed when a new session is started. "

	^ 'PharoFTP ready'
]
