"
The MLST and MLSD commands are intended to standardize the file and directory information returned by the Server-FTP process.  These commands differ from the LIST command in that the format of the replies is strictly defined although extensible.

Two commands are defined, MLST which provides data about exactly the object named on its command line, and no others. MLSD on the other hand will list the contents of a directory if a directory is named, otherwise a 501 reply will be returned. In either case, if no object is named, the current directory is assumed. That will cause MLST to send a one line response, describing the current directory itself, and MLSD to list the contents of the current directory.
"
Class {
	#name : #FTPMlstVerb,
	#superclass : #FTPListingVerb,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPMlstVerb class >> features [
	^ #( 'MLST Type*;Size*;Modify*;Create*;Unique*' )
]

{ #category : #accessing }
FTPMlstVerb class >> verbs [
	^ Array with: 'MLST'.
]

{ #category : #querying }
FTPMlstVerb >> creationOf: aContext [
	^ self tuple: 'Create' with: aContext creation asSeconds.
]

{ #category : #processing }
FTPMlstVerb >> execute [
	self return: (FTPResponse code: 250 string: (String streamContents: [ :stream |
		stream nextPutAll: 'Listing of "'; nextPutAll: self context pathString; nextPut: $"; cr.
		self children do: [ :context |
			self selectors
				do: [ :each | stream nextPutAll: (self perform: each with: context) ]
				separatedBy: [ stream nextPut: self separator ].
			stream cr ].
		stream nextPutAll: 'END' ])).
]

{ #category : #processing }
FTPMlstVerb >> executeOn: aStream [
	self return: (FTPResponse code: 250 string: (String streamContents: [ :stream |
		stream nextPutAll: 'Listing of "'; nextPutAll: self context pathString; nextPutAll: '":'; cr.
		self executeOn: aStream.
		stream nextPutAll: 'END' ])).
]

{ #category : #querying }
FTPMlstVerb >> modificationOf: aContext [
	^ self tuple: 'Modify' with: aContext modification asSeconds.
]

{ #category : #accessing }
FTPMlstVerb >> selectors [
	^ #( typeOf: sizeOf: modificationOf: creationOf: uniqueOf: nameOf: ).
]

{ #category : #accessing }
FTPMlstVerb >> separator [
	^ $;
]

{ #category : #querying }
FTPMlstVerb >> sizeOf: aContext [
	^ self tuple: 'Size' with: (super sizeOf: aContext).
]

{ #category : #private }
FTPMlstVerb >> tuple: aKey with: anObject [
	^ String streamContents: [ :stream | 
		stream nextPutAll: aKey; nextPut: $=; nextPutAll: anObject asString ].
]

{ #category : #querying }
FTPMlstVerb >> typeOf: aContext [
	^ self tuple: 'Type' with: (aContext isFile ifTrue: [ 'file' ] ifFalse: [ 'dir' ]).
]

{ #category : #querying }
FTPMlstVerb >> uniqueOf: aContext [
	^ self tuple: 'Unique' with: aContext hash.
]
