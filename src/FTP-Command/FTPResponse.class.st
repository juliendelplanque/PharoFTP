Class {
	#name : #FTPResponse,
	#superclass : #FTPMessage,
	#instVars : [
		'code',
		'lines'
	],
	#category : 'FTP-Server'
}

{ #category : #'instance creation' }
FTPResponse class >> code: anInteger [
	^ self code: anInteger line: 'OK'.

]

{ #category : #'instance creation' }
FTPResponse class >> code: anInteger line: aString [
	^ self code: anInteger lines: (Array with: aString).
]

{ #category : #'instance creation' }
FTPResponse class >> code: anInteger lines: aCollection [
	^ self new
		setCode: anInteger;
		setLines: aCollection;
		yourself.
]

{ #category : #'instance creation' }
FTPResponse class >> code: anInteger string: aString [
	^ self code: anInteger lines: (aString findTokens: Character cr).
]

{ #category : #errors }
FTPResponse class >> error: aString [
	"The request violated some internal parsing rule in the server."

	^ self code: 500 line: aString.
]

{ #category : #rejecting }
FTPResponse class >> invalidCommand [
	"The server does not like the command."

	^ self code: 500 line: 'Invalid command'.
]

{ #category : #rejecting }
FTPResponse class >> invalidParamter [
	"The server does not like the format of the parameter."

	^ self code: 501 line: 'Invalid parameter format'.
]

{ #category : #errors }
FTPResponse class >> notFound [
	^ self code: 550 line: 'No such file or directory'.
]

{ #category : #accepting }
FTPResponse class >> okay [
	^ self code: 200.
]

{ #category : #accepting }
FTPResponse class >> ready [
	^ self code: 220 line: 'SqueakFTP ready'.
]

{ #category : #rejecting }
FTPResponse class >> unsupportedCommand [
	"The server recognized the verb but does not support it."

	^ self code: 502 line: 'Unsupported command'.
]

{ #category : #rejecting }
FTPResponse class >> unsupportedParameter [
	"The server supports the verb but does not support the parameter."
	
	^ self code: 504 line: 'Unsupported parameter'.
]

{ #category : #actions }
FTPResponse >> add: aString [
	self lines add: aString.
]

{ #category : #accessing }
FTPResponse >> code [
	^ code
]

{ #category : #accessing }
FTPResponse >> lines [
	^ lines
]

{ #category : #printing }
FTPResponse >> logOn: aStream [
	self writeOn: aStream ident: '<< '.
]

{ #category : #printing }
FTPResponse >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' code: '; print: self code.
	aStream nextPutAll: ' lines: '; print: self lines.
]

{ #category : #initialization }
FTPResponse >> setCode: aNumber [
	code := aNumber
]

{ #category : #initialization }
FTPResponse >> setLines: aCollection [
	lines := aCollection
]

{ #category : #printing }
FTPResponse >> writeOn: aStream ident: aString [
	1 to: self lines size do: [ :index |
		aStream nextPutAll: aString; print: self code.
		aStream nextPut: (self lines size = index
			ifTrue: [ $  ] ifFalse: [ $- ]).
		aStream nextPutAll: (self lines at: index).
		aStream nextPutAll: String crlf ].
	aStream flush.
]
