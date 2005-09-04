"
A directory is a list of files. It typically includes a name, type, size, and modification time of each file. The difference between LIST and NLST is that NLST returns a compressed form of the directory, showing only the name of each file, while LIST returns the entire directory.
"
Class {
	#name : #FTPListingVerb,
	#superclass : #FTPVerb,
	#instVars : [
		'lines',
		'sizes'
	],
	#category : 'FTP-Verbs'
}

{ #category : #private }
FTPListingVerb >> build [
	lines := self children collect: [ :child |
		self selectors collect: [ :selector |
			self perform: selector with: child ] ].
	sizes := (1 to: self padding size) collect: [ :index |
		self lines inject: 0 into: [ :result :each |
			result max: (each at: index) size ] ].
]

{ #category : #accessing }
FTPListingVerb >> children [
	^ self context children.
]

{ #category : #processing }
FTPListingVerb >> execute [
	(FTPResponse code: 150)
		writeOn: self session telnet stream.
	self session withStreamDo: [ :stream |
		self executeOn: stream ].
	self return: (FTPResponse code: 226).
]

{ #category : #processing }
FTPListingVerb >> executeOn: aStream [
	self lines do: [ :line |
		(1 to: self selectors size) 
			do: [ :index |
				aStream nextPutAll: ((line at: index)	
					padded: (self padding at: index)
					to: (self sizes at: index)
					with: $ ) ]
			separatedBy: [ aStream nextPut: self separator ].
		aStream crlf ].

]

{ #category : #querying }
FTPListingVerb >> groupOf: aContext [
	^ aContext groupName.
]

{ #category : #private }
FTPListingVerb >> lines [
	lines isNil ifTrue: [ self build ].
	^ lines.
]

{ #category : #querying }
FTPListingVerb >> nameOf: aContext [
	^ aContext name.
]

{ #category : #accessing }
FTPListingVerb >> padding [
	self subclassResponsibility.
]

{ #category : #querying }
FTPListingVerb >> permissionsOf: aContext [
	^ String streamContents: [ :stream |
		stream nextPut: (aContext isDirectory ifTrue: [ $d ] ifFalse: [ $- ]).
		stream nextPut: (aContext isUserReadable ifTrue: [ $r ] ifFalse: [ $- ]).
		stream nextPut: (aContext isUserWriteable ifTrue: [ $w ] ifFalse: [ $- ]).
		stream nextPut: (aContext isUserExecutable ifTrue: [ $x ] ifFalse: [ $- ]).
		stream nextPut: (aContext isGroupReadable ifTrue: [ $r ] ifFalse: [ $- ]).
		stream nextPut: (aContext isGroupWriteable ifTrue: [ $w ] ifFalse: [ $- ]).
		stream nextPut: (aContext isGroupExecutable ifTrue: [ $x ] ifFalse: [ $- ]).
		stream nextPut: (aContext isOtherReadable ifTrue: [ $r ] ifFalse: [ $- ]).
		stream nextPut: (aContext isOtherWriteable ifTrue: [ $w ] ifFalse: [ $- ]).
		stream nextPut: (aContext isOtherExecutable ifTrue: [ $x ] ifFalse: [ $- ]) ].
]

{ #category : #querying }
FTPListingVerb >> referencesOf: aContext [
	^ aContext references asString.
]

{ #category : #accessing }
FTPListingVerb >> selectors [
	self subclassResponsibility.
]

{ #category : #accessing }
FTPListingVerb >> separator [
	^ Character space.
]

{ #category : #querying }
FTPListingVerb >> sizeOf: aContext [
	^ aContext size asString.
]

{ #category : #private }
FTPListingVerb >> sizes [
	sizes isNil ifTrue: [ self build ].
	^ sizes.
]

{ #category : #querying }
FTPListingVerb >> timestampOf: aContext [
	| stamp |
	stamp := aContext modification ifNil: [ TimeStamp now ].
	^ String streamContents: [ :stream |
		stream nextPutAll: (stamp monthName copyFrom: 1 to: 3); space.
		stream nextPutAll: (stamp daysInMonth asString padded: #left to: 2 with: $ ); space.
		86400 * stamp asYear daysInYear + stamp asSeconds < TimeStamp now asSeconds
			ifTrue: [ stream nextPutAll: (stamp year asString padded: #left to: 4 with: $ ) ]
			ifFalse: [
				stream nextPutAll: (stamp hours asString padded: #left to: 2 with: $0); nextPut: $:.
				stream nextPutAll: (stamp minutes asString padded: #left to: 2 with: $0) ] ].
]

{ #category : #querying }
FTPListingVerb >> userOf: aContext [
	^ aContext userName.
]
