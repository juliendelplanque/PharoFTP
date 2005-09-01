Class {
	#name : #FTPPortCommand,
	#superclass : #FTPCommand,
	#instVars : [
		'numbers'
	],
	#category : 'FTP-Command'
}

{ #category : #accessing }
FTPPortCommand class >> command [
	^ 'PORT'
]

{ #category : #processing }
FTPPortCommand >> execute [
	self parseArgument.
	self state
		passive: false;
		ip: (ByteArray
			with: numbers first with: numbers second
			with: numbers third with: numbers fourth);
		port: numbers fifth * 256 + numbers sixth.
	self return: FTPResponse okay.
]

{ #category : #private }
FTPPortCommand >> parseArgument [
	numbers := self request argument findTokens: $,.
	(numbers size = 6 and: [ numbers allSatisfy: [ :each | each isAllDigits ] ])
		ifFalse: [ self return: FTPResponse unsupportedParameter ].
	numbers := numbers collect: [ :each | each asInteger ].
	(numbers allSatisfy: [ :each | each between: 0 and: 256 ])
		ifFalse: [ self return: FTPResponse invalidParamter ].
]
