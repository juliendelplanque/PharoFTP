"
A RETR request asks the server to send the contents of a file over the data connection already established by the client. The RETR parameter is an encoded pathname of the file. The file is either a binary file or a text file, depending on the most recent TYPE request.
Normally the server responds with a mark using code 150. It then stops accepting new connections, attempts to send the contents of the file over the data connection, and closes the data connection. Finally it

- accepts the RETR request with code 226 if the entire file was successfully written to the server's TCP buffers;
- rejects the RETR request with code 425 if no TCP connection was established;
- rejects the RETR request with code 426 if the TCP connection was established but then broken by the client or by network failure; or
rejects the RETR request with code 451 or 551 if the server had trouble reading the file from disk.

The server is obliged to close the data connection in each of these cases. The client is not expected to look for a response from the server until the client sees that the data connection is closed.
"
Class {
	#name : #FTPRetrVerb,
	#superclass : #FTPTransfer,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPRetrVerb class >> verbs [
	^ Array with: 'RETR'.
]

{ #category : #private }
FTPRetrVerb >> cleanup: aContext [
	self state position: 0.
]

{ #category : #private }
FTPRetrVerb >> lookup [
	^ self findContext: self request argument type: #file.
]

{ #category : #private }
FTPRetrVerb >> process: aContext on: aStream [
	aContext get: aStream startingAt: self state position.
]
