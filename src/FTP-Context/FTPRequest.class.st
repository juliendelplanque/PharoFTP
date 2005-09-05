Class {
	#name : #FTPRequest,
	#superclass : #FTPMessage,
	#instVars : [
		'verb',
		'argument'
	],
	#category : 'FTP-Server'
}

{ #category : #'instance creation' }
FTPRequest class >> readFrom: aStream [
	| line |
	line := aStream upTo: Character lf.
	(line notEmpty and: [ line last = Character cr ])
		ifTrue: [ line := line allButLast ].
	^ self new
		setVerb: (line copyUpTo: $ );
		setArgument: (line copyAfter: $ );
		yourself.
]

{ #category : #accessing }
FTPRequest >> argument [
	^ argument
]

{ #category : #printing }
FTPRequest >> logOn: aStream [
	self writeOn: aStream ident: '>> '.
]

{ #category : #conveniance }
FTPRequest >> normalized [
	^ self argument withBlanksTrimmed asUppercase.
]

{ #category : #printing }
FTPRequest >> printOn: aStream [ 
	super printOn: aStream.
	aStream nextPutAll: ' verb: '; print: self verb.
	aStream nextPutAll: ' argument: '; print: self argument.
]

{ #category : #initialization }
FTPRequest >> setArgument: aString [
	argument := aString
]

{ #category : #initialization }
FTPRequest >> setVerb: aString [
	verb := aString asUppercase.
]

{ #category : #accessing }
FTPRequest >> verb [
	^ verb
]

{ #category : #printing }
FTPRequest >> writeOn: aStream ident: aString [
	aStream nextPutAll: aString; nextPutAll: self verb.
	aStream space; nextPutAll: self argument.
	aStream nextPutAll: String crlf; flush.
]
