"
A CWD request has a nonempty parameter giving an encoded pathname. It asks the server to set the name prefix to this pathname, or to another pathname that will have the same effect as this pathname if the filesystem does not change. The server may accept a CWD request using code 200 or 250. The server may reject a CWD request using code 550.
"
Class {
	#name : #FTPCwdCommand,
	#superclass : #FTPFileCommand,
	#category : 'FTP-Command-Navigation'
}

{ #category : #accessing }
FTPCwdCommand class >> command [
	^ 'CWD'
]

{ #category : #processing }
FTPCwdCommand >> execute [
	self checkTarget: #isDirectoryContext.
	self context: self target; return: FTPResponse okay.
]
