"
This command terminates a USER and if file transfer is not in progress, the server closes the control connection. If file transfer is in progress, the connection will remain open for result response and the server will then close it. If the user-process is transferring files for several USERs but does not wish to close and then reopen connections for each, then the REIN command should be used instead of QUIT.
	
An unexpected close on the control connection will cause the server to take the effective action of an abort (ABOR) and a logout (QUIT).
"
Class {
	#name : #FTPQuitVerb,
	#superclass : #FTPVerb,
	#category : #'FTP-Verbs'
}

{ #category : #accessing }
FTPQuitVerb class >> verbs [
	^ Array with: 'QUIT'.
]

{ #category : #processing }
FTPQuitVerb >> execute [
	self response: (FTPResponse code: 221 string: self context goodbyeString).
	self session close.
]
