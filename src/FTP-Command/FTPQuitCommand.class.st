"
This command terminates a USER and if file transfer is not in progress, the server closes the control connection. If file transfer is in progress, the connection will remain open for result response and the server will then close it. If the user-process is transferring files for several USERs but does not wish to close and then reopen connections for each, then the REIN command should be used instead of QUIT.
	
An unexpected close on the control connection will cause the server to take the effective action of an abort (ABOR) and a logout (QUIT).
"
Class {
	#name : #FTPQuitCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command-Session'
}

{ #category : #accessing }
FTPQuitCommand class >> command [
	^ 'QUIT'
]

{ #category : #processing }
FTPQuitCommand >> execute [
	self session close.
]
