"
This command does not affect any parameters or previously entered commands. It specifies no action other than that the server send an OK reply.
"
Class {
	#name : #FTPNoopVerb,
	#superclass : #FTPVerb,
	#category : #'FTP-Verbs'
}

{ #category : #accessing }
FTPNoopVerb class >> verbs [
	^ Array with: 'ALLO' with: 'NOOP'.
]

{ #category : #processing }
FTPNoopVerb >> execute [
	self return: FTPResponse okay.
]
