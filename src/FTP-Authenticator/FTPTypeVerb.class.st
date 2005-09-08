"
The server keeps track of a binary flag for the client. At any moment, the binary flag is either on or off. At the beginning of the FTP connection, the binary flag is off.

A - Turn the binary flag off.
A N - Turn the binary flag off.
I - Turn the binary flag on.
L 8 - Turn the binary flag on.
"
Class {
	#name : #FTPTypeVerb,
	#superclass : #FTPVerb,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPTypeVerb class >> verbs [
	^ Array with: 'TYPE'.
]

{ #category : #processing }
FTPTypeVerb >> ascii [
	self state binary: false.
	self return: (FTPResponse code: 200 line: 'set to ascii').
]

{ #category : #accessing }
FTPTypeVerb >> asciiArguments [
	^ #( 'A' 'A N' )
]

{ #category : #processing }
FTPTypeVerb >> binary [
	self state binary: true.
	self return: (FTPResponse code: 200 line: 'set to binary').
]

{ #category : #accessing }
FTPTypeVerb >> binaryArguments [
	^ #( 'I' 'L 8' )
]

{ #category : #processing }
FTPTypeVerb >> execute [
	(self binaryArguments includes: self request normalized)
		ifTrue: [ self binary ].
	(self asciiArguments includes: self request normalized)
		ifTrue: [ self ascii ].
	self return: FTPResponse invalidParamter.
]
