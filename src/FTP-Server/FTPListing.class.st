"
A directory is a list of files. It typically includes a name, type, size, and modification time of each file. The difference between LIST and NLST is that NLST returns a compressed form of the directory, showing only the name of each file, while LIST returns the entire directory.
"
Class {
	#name : #FTPListing,
	#superclass : #FTPVerb,
	#category : #'FTP-Verbs'
}

{ #category : #accessing }
FTPListing >> children [
	| context |
	context := self findContext: self request argument.
	^ context isFile
		ifTrue: [ Array with: context ]
		ifFalse: [ context children ].
]

{ #category : #processing }
FTPListing >> execute [
	self response: (FTPResponse code: 150).
	self session withStreamDo: [ :stream |
		self print: self children on: stream ].
	self return: (FTPResponse code: 226).
]

{ #category : #printing }
FTPListing >> print: aCollection on: aStream [
	aCollection do: [ :each | self printContext: each on: aStream ].
]

{ #category : #printing }
FTPListing >> printContext: aContext on: aStream [
	self subclassResponsibility.
]

{ #category : #printing }
FTPListing >> printGroup: aContext on: aStream [
	aStream nextPutAll: aContext groupName.
]

{ #category : #printing }
FTPListing >> printMode: aContext on: aStream [
	aContext isDirectory 
		ifTrue: [ 
			aStream nextPut: $d.
			3 timesRepeat: [
				aStream nextPut: (aContext canBeListed ifTrue: [ $r ] ifFalse: [ $- ]).
				aStream nextPut: (aContext canCreate ifTrue: [ $w ] ifFalse: [ $- ]).
				aStream nextPut: (aContext canBeListed ifTrue: [ $x ] ifFalse: [ $- ]) ] ]
		ifFalse: [
			aStream nextPut: $-.
			3 timesRepeat: [
				aStream nextPut: (aContext canRead ifTrue: [ $r ] ifFalse: [ $- ]).
				aStream nextPut: (aContext canWrite ifTrue: [ $w ] ifFalse: [ $- ]).
				aStream nextPut: $- ] ].
]

{ #category : #printing }
FTPListing >> printName: aContext on: aStream [
	aStream nextPutAll: aContext name.
]

{ #category : #printing }
FTPListing >> printOwner: aContext on: aStream [
	aStream nextPutAll: aContext ownerName.
]

{ #category : #printing }
FTPListing >> printReferences: aContext on: aStream [
	aStream print: aContext references.
]

{ #category : #printing }
FTPListing >> printSize: aContext on: aStream [
	aStream print: aContext size.
]

{ #category : #printing }
FTPListing >> printTimestamp: aContext on: aStream [
	aContext modification in: [ :timestamp |
		aStream nextPutAll: (timestamp monthName copyFrom: 1 to: 3); space.
		aStream nextPutAll: (timestamp daysInMonth asString padded: #left to: 2 with: $ ); space.
		86400 * timestamp asYear daysInYear + timestamp asSeconds < TimeStamp now asSeconds
			ifTrue: [ aStream nextPutAll: (timestamp year asString padded: #left to: 4 with: $ ) ]
			ifFalse: [
				aStream nextPutAll: (timestamp hours asString padded: #left to: 2 with: $0); nextPut: $:.
				aStream nextPutAll: (timestamp minutes asString padded: #left to: 2 with: $0) ] ].
]
