"
The MLST and MLSD commands are intended to standardize the file and directory information returned by the Server-FTP process. These commands differ from the LIST command in that the format of the replies is strictly defined although extensible.

Two commands are defined, MLST which provides data about exactly the object named on its command line, and no others. MLSD on the other hand will list the contents of a directory if a directory is named, otherwise a 501 reply will be returned. In either case, if no object is named, the current directory is assumed. That will cause MLST to send a one line response, describing the current directory itself, and MLSD to list the contents of the current directory.
"
Class {
	#name : #FTPModernListing,
	#superclass : #FTPListing,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPModernListing class >> features [
	^ #( 'MLST Size*;Modify*;Create*;Type*;Unique*;Perm*;UNIX.mode*;UNIX.owner*;UNIX.group*;' 'TVFS' )
]

{ #category : #printing }
FTPModernListing >> printContext: aContext on: aStream [
	self selectors do: [ :each | 
		self perform: each with: aContext with: aStream.
		aStream nextPut: $; ].
	self printName: aContext on: aStream.
	aStream nextPutAll: String crlf.
]

{ #category : #printing }
FTPModernListing >> printCreate: aContext on: aStream [
	self printTag: 'Create' on: aStream.
	aStream nextPutAll: aContext creation asFtpTimeStamp.
]

{ #category : #printing }
FTPModernListing >> printGroup: aContext on: aStream [
	self printTag: 'UNIX.group' on: aStream.
	super printGroup: aContext on: aStream.
]

{ #category : #printing }
FTPModernListing >> printMode: aContext on: aStream [
	self printTag: 'UNIX.mode' on: aStream.
	super printMode: aContext on: aStream.
]

{ #category : #printing }
FTPModernListing >> printModify: aContext on: aStream [
	self printTag: 'Modify' on: aStream.
	aStream nextPutAll: aContext modification asFtpTimeStamp.
]

{ #category : #printing }
FTPModernListing >> printName: aContext on: aStream [
	aStream nextPut: Character space.
	super printName: aContext on: aStream.
]

{ #category : #printing }
FTPModernListing >> printOwner: aContext on: aStream [
	self printTag: 'UNIX.owner' on: aStream.
	super printOwner: aContext on: aStream.
]

{ #category : #printing }
FTPModernListing >> printPerm: aContext on: aStream [ 
	self printTag: 'Perm' on: aStream.
	aContext canAppend ifTrue: [ aStream nextPut: $a ].
	aContext canCreate ifTrue: [ aStream nextPut: $c ].
	aContext canBeDeleted ifTrue: [ aStream nextPut: $d ].
	aContext canBeListed ifTrue: [ aStream nextPut: $e ].
	aContext canBeRenamed ifTrue: [ aStream nextPut: $f ].
	aContext canBeListed ifTrue: [ aStream nextPut: $l ].
	aContext canCreate ifTrue: [ aStream nextPut: $m ].	
	aContext canRead ifTrue: [ aStream nextPut: $r ].
	aContext canWrite ifTrue: [ aStream nextPut: $w ].
]

{ #category : #printing }
FTPModernListing >> printSize: aContext on: aStream [
	self printTag: 'Size' on: aStream.
	super printSize: aContext on: aStream.
]

{ #category : #printing }
FTPModernListing >> printTag: aString on: aStream [
	aStream nextPutAll: aString; nextPut: $=.
]

{ #category : #printing }
FTPModernListing >> printType: aContext on: aStream [
	self printTag: 'Type' on: aStream.
	aStream nextPutAll: (aContext isDirectory ifTrue: [ 'dir' ] ifFalse: [ 'file' ]).
]

{ #category : #printing }
FTPModernListing >> printUnique: aContext on: aStream [
	self printTag: 'unique' on: aStream.
	aStream print: aContext hash.
]

{ #category : #accessing }
FTPModernListing >> selectors [
	^ #( printSize:on: printModify:on: printCreate:on: printType:on: printUnique:on: printPerm:on: printMode:on: printOwner:on: printGroup:on: )
]
