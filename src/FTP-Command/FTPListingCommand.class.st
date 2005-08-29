"
A directory is a list of files. It typically includes a name, type, size, and modification time of each file. The difference between LIST and NLST is that NLST returns a compressed form of the directory, showing only the name of each file, while LIST returns the entire directory.
"
Class {
	#name : #FTPListingCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command-Navigation'
}

{ #category : #processing }
FTPListingCommand >> execute [
	(FTPResponse code: 150)
		writeOn: self connection stream.
	self session withStreamDo: [ :stream |
		self context children do: [ :child |
			self selectors
				do: [ :selector | self perform: selector with: child with: stream ]
				separatedBy: [ stream space ].
			stream crlf ].
		stream flush ].
	self return: (FTPResponse code: 226).
]

{ #category : #printing }
FTPListingCommand >> printGroup: aContext on: aStream [
	aStream nextPutAll: aContext groupName.
]

{ #category : #printing }
FTPListingCommand >> printName: aContext on: aStream [
	aStream nextPutAll: aContext name.
]

{ #category : #printing }
FTPListingCommand >> printPermission: aContext on: aStream [
	aStream nextPut: (aContext isDirectory ifTrue: [ $d ] ifFalse: [ $- ]).
	aStream nextPut: (aContext isUserReadable ifTrue: [ $r ] ifFalse: [ $- ]).
	aStream nextPut: (aContext isUserWriteable ifTrue: [ $w ] ifFalse: [ $- ]).
	aStream nextPut: (aContext isUserExecutable ifTrue: [ $x ] ifFalse: [ $- ]).
	aStream nextPut: (aContext isGroupReadable ifTrue: [ $r ] ifFalse: [ $- ]).
	aStream nextPut: (aContext isGroupWriteable ifTrue: [ $w ] ifFalse: [ $- ]).
	aStream nextPut: (aContext isGroupExecutable ifTrue: [ $x ] ifFalse: [ $- ]).
	aStream nextPut: (aContext isOtherReadable ifTrue: [ $r ] ifFalse: [ $- ]).
	aStream nextPut: (aContext isOtherWriteable ifTrue: [ $w ] ifFalse: [ $- ]).
	aStream nextPut: (aContext isOtherExecutable ifTrue: [ $x ] ifFalse: [ $- ]).
]

{ #category : #printing }
FTPListingCommand >> printReferences: aContext on: aStream [
	aStream nextPut: $1.
]

{ #category : #printing }
FTPListingCommand >> printSize: aContext on: aStream [
	aStream print: aContext size.
]

{ #category : #printing }
FTPListingCommand >> printTimestamp: aContext on: aStream [
	| stamp |
	stamp := aContext timestamp ifNil: [ TimeStamp now ].
	aStream nextPutAll: (stamp monthName copyFrom: 1 to: 3); space.
	aStream nextPutAll: (stamp daysInMonth asString padded: #left to: 2 with: $ ); space.
	86400 * stamp asYear daysInYear + stamp asSeconds < TimeStamp now asSeconds
		ifTrue: [ aStream nextPutAll: (stamp year asString padded: #left to: 4 with: $ ) ]
		ifFalse: [
			aStream nextPutAll: (stamp hours asString padded: #left to: 2 with: $0); nextPut: $:.
			aStream nextPutAll: (stamp minutes asString padded: #left to: 2 with: $0) ].
]

{ #category : #printing }
FTPListingCommand >> printUser: aContext on: aStream [
	aStream nextPutAll: aContext userName.
]

{ #category : #accessing }
FTPListingCommand >> selectors [
	self subclassResponsibility.
]
