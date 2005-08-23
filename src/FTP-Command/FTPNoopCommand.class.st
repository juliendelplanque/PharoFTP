"
This command does not affect any parameters or previously entered commands. It specifies no action other than that the server send an OK reply.
"
Class {
	#name : #FTPNoopCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command-Information'
}

{ #category : #accessing }
FTPNoopCommand class >> command [
	^ 'NOOP'
]

{ #category : #processing }
FTPNoopCommand >> execute [
	self return: FTPResponse okay.
]
