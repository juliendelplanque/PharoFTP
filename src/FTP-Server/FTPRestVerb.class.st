"
The server keeps track of a start position for the client. The start position is a nonnegative integer. At the beginning of the FTP connection, the start position is 0.

A REST request sets the start position. REST has a parameter giving a number as ASCII digits. If the server accepts the REST request (required code 350), it has set the start position to that number. If the server rejects the REST request, it has left the start position alone.

The server will set the start position to 0 after a successful RETR, but might not set the start position to 0 after an unsuccessful RETR, so the client must be careful to send a new REST request before the next RETR. The server might set the start position to 0 after responding to any request other than REST, so the client must send REST immediately before RETR.
"
Class {
	#name : #FTPRestVerb,
	#superclass : #FTPVerb,
	#category : #'FTP-Verbs'
}

{ #category : #accessing }
FTPRestVerb class >> features [
	^ Array with: 'REST STREAM'.
]

{ #category : #accessing }
FTPRestVerb class >> verbs [
	^ Array with: 'REST'.
]

{ #category : #processing }
FTPRestVerb >> execute [	
	self request argument isAllDigits
		ifFalse: [ self return: (FTPResponse invalidParamter) ].
	self state position: (self request argument asInteger ifNil: [ 0 ]).
	self return: (FTPResponse code: 350 string: 'Restarting at ' , self state position asString).
]
