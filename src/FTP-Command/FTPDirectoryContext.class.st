Class {
	#name : #FTPDirectoryContext,
	#superclass : #FTPContext,
	#category : 'FTP-Context'
}

{ #category : #events }
FTPDirectoryContext >> unknownRequest: aRequest [
	" This message will be sent for any unknown command, sublcasses might override the default implementation to handle additional user defined verbs. "

	self session returnResponse: FTPResponse invalidCommand.
]

{ #category : #events }
FTPDirectoryContext >> updateAuthentication [
	" This message will be sent whenever a new username or password is given. "
]
