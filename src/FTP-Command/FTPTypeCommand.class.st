"
The server keeps track of a binary flag for the client. At any moment, the binary flag is either on or off. At the beginning of the FTP connection, the binary flag is off.

A - Turn the binary flag off.
A N - Turn the binary flag off.
I - Turn the binary flag on.
L 8 - Turn the binary flag on.
"
Class {
	#name : #FTPTypeCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command-Settings'
}

{ #category : #accessing }
FTPTypeCommand class >> command [
	^ 'TYPE'
]

{ #category : #processing }
FTPTypeCommand >> ascii [
	self state binary: false.
	self return: (FTPResponse code: 200 line: 'set to ascii').
]

{ #category : #accessing }
FTPTypeCommand >> asciiArguments [
	^ #( 'A' 'A N' )
]

{ #category : #processing }
FTPTypeCommand >> binary [
	self state binary: true.
	self return: (FTPResponse code: 200 line: 'set to binary').
]

{ #category : #accessing }
FTPTypeCommand >> binaryArguments [
	^ #( 'I' 'L 8' )
]

{ #category : #processing }
FTPTypeCommand >> execute [
	(self binaryArguments includes: self request normalized)
		ifTrue: [ self binary ].
	(self asciiArguments includes: self request normalized)
		ifTrue: [ self ascii ].
	self return: FTPResponse invalidParamter.
]
