"
A PASV request asks the server to accept a data connection on a new TCP port selected by the server. PASV parameters are prohibited. The server normally accepts PASV with code 227. Its response is a single line showing the IP address of the server and the TCP port number where the server is accepting connections. 

Normally the client will connect to this TCP port, from the same IP address that the client is using for the FTP connection, and then send a RETR request. However, the client may send some other requests first, such as REST. The server must continue to read and respond to requests while it accepts connections. Most operating systems handle this automatically. If the client sends another PASV request, the server normally accepts the new request with a new TCP port. It stops listening for connections on the old port, and drops any connections already made.

"
Class {
	#name : #FTPPasvVerb,
	#superclass : #FTPVerb,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPPasvVerb class >> verbs [
	^ Array with: 'PASV'.
]

{ #category : #processing }
FTPPasvVerb >> execute [
	self request argument notEmpty 
		ifTrue: [ self return: FTPResponse unsupportedParameter ].
	self state 
		passive: true;
		ip: NetNameResolver localHostAddress;
		port: 34558.
	self return: (FTPResponse
		code: 227 
		line: (String streamContents: [ :stream |
			self state ip do: [ :each | stream print: each; nextPut: $, ].
			stream print: self state port // 256; nextPut: $,; print: self state port \\ 256 ])).
]
