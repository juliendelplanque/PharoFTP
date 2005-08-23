Class {
	#name : #FTPRequest,
	#superclass : #FTPMessage,
	#instVars : [
		'command',
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
		setCommand: (line copyUpTo: $ );
		setArgument: (line copyAfter: $ );
		yourself.
]

{ #category : #accessing }
FTPRequest >> argument [
	^ argument
]

{ #category : #accessing }
FTPRequest >> command [
	^ command
]

{ #category : #printing }
FTPRequest >> logOn: aStream [
	self writeOn: aStream ident: '>> '.
]

{ #category : #'accessing-dynamic' }
FTPRequest >> normalized [
	^ self argument withBlanksTrimmed asUppercase.
]

{ #category : #printing }
FTPRequest >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' command: '; print: self command.
	aStream nextPutAll: ' argument: '; print: self argument.
]

{ #category : #initialization }
FTPRequest >> setArgument: aString [
	argument := aString
]

{ #category : #initialization }
FTPRequest >> setCommand: aString [
	command := aString asUppercase.
]

{ #category : #printing }
FTPRequest >> writeOn: aStream ident: aString [
	aStream nextPutAll: aString; nextPutAll: command.
	aStream space; nextPutAll: self argument.
	aStream nextPutAll: String crlf; flush.
]
