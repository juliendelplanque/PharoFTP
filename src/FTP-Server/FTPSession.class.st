Class {
	#name : #FTPSession,
	#superclass : #Object,
	#instVars : [
		'server',
		'context',
		'socket',
		'stream',
		'process'
	],
	#category : 'FTP-Server'
}

{ #category : #'instance-creation' }
FTPSession class >> start: aContext socket: aSocket server: aServer [
	self new
		setSocket: aSocket server: aServer;
		context: aContext;
		start.
]

{ #category : #'commands-file-transfer' }
FTPSession >> abor: aString [
	self writeStatus: 502.
]

{ #category : #'commands-login' }
FTPSession >> acct: aString [
	"The argument field is a Telnet string identifying the user's account. The command is not necessarily related to the USER command, as some sites may require an account for login and others only for specific access, such as storing files. In the latter case the command may arrive at any time.

	There are reply codes to differentiate these cases for the automation: when account information is required for login, the response to a successful PASSword command is reply code 332. On the other hand, if account information is NOT required for login, the reply to a successful PASSword command is 230; and if the account information is needed for  a command issued later in the dialogue, the server should return a 332 or 532 reply depending on whether it stores (pending receipt of the ACCounT command) or discards the command, respectively."
	
	self writeStatus: 502.

]

{ #category : #'commands-file-actions' }
FTPSession >> allo: aString [
	self writeStatus: 502.
]

{ #category : #'commands-file-transfer' }
FTPSession >> appe: aString [
	self writeStatus: 502.
]

{ #category : #'commands-login' }
FTPSession >> cdup: aString [
	"This command is a special case of CWD, and is included to simplify the implementation of programs for transferring directory trees between operating systems having different syntaxes for naming the parent directory. The reply codes shall be identical to the reply codes of CWD."
	
	self context: (self context changeToParent).
	self writeStatus: 250.
]

{ #category : #accessing }
FTPSession >> context [
	^context
]

{ #category : #accessing }
FTPSession >> context: aContext [
	context := aContext.
]

{ #category : #'private-server' }
FTPSession >> createServer [
	process := Process 
		forContext: [
			[ self sessionLoop ]
				ensure: [ self destroyServer ] ]
		priority: self server priority.
]

{ #category : #'commands-login' }
FTPSession >> cwd: aString [
	"This command allows the user to work with a different directory or dataset for file storage or retrieval without altering his login or accounting information. Transfer parameters are similarly unchanged. The argument is a pathname specifying a directory or other system dependent file group designator."
	
	self context: (self context changeWorkingDirectory: aString).
	self writeStatus: 250.
]

{ #category : #'commands-file-transfer' }
FTPSession >> dele: aString [
	self writeStatus: 502.
]

{ #category : #'private-server' }
FTPSession >> destroyServer [
	self stream close. 
	self socket destroy. 
	process := socket := stream := nil.
]

{ #category : #'private-server' }
FTPSession >> execute: aString [
	| command selector argument |
	Transcript show: '>> '; show: aString; cr.
	aString isEmptyOrNil ifFalse: [
		command := aString copyUpTo: $ .
		command notEmpty ifTrue: [
			selector := (command asLowercase copyWith: $:)
				asSymbol.
			(self isValidCommand: selector) ifTrue: [
				argument := aString copyAfter: $ .
				^self perform: selector with: argument ] ] ].
	FTPStatusNotification notImplemented.
]

{ #category : #'commands-informational' }
FTPSession >> help: aString [
	self write: self context help.
]

{ #category : #testing }
FTPSession >> isConnected [
	^self socket isValid 
		and: [ self socket isConnected ].
]

{ #category : #testing }
FTPSession >> isRunning [
	^self process notNil.
]

{ #category : #testing }
FTPSession >> isValidCommand: aSelector [
	| category |
	category := self class whichCategoryIncludesSelector: aSelector.
	^category notNil and: [ category beginsWith: 'commands' ].
]

{ #category : #'commands-file-transfer' }
FTPSession >> list: aString [
	self context listTo: self.
	self writeStatus: 226.
]

{ #category : #'commands-file-transfer' }
FTPSession >> mkd: aString [
	self writeStatus: 502.
]

{ #category : #'commands-parameters' }
FTPSession >> mode: aString [
	self halt.
]

{ #category : #'commands-file-transfer' }
FTPSession >> nlst: aString [
	self writeStatus: 502.
]

{ #category : #'commands-miscellaneous' }
FTPSession >> noop: aString [
	"This command does not affect any parameters or previously entered commands. It specifies no action other than that the server send an OK reply."

	self writeStatus: 200.
]

{ #category : #'commands-login' }
FTPSession >> pass: aString [
	"The argument field is a Telnet string specifying the user's password.  This command must be immediately preceded by the user name command, and, for some sites, completes the user's identification for access control. Since password information is quite sensitive, it is desirable in general to 'mask' it or suppress typeout. It appears that the server has no foolproof way to achieve this. It is therefore the responsibility of the user-FTP process to hide the sensitive password information."
	
	self context password: aString.
	self writeStatus: 200.
]

{ #category : #'commands-parameters' }
FTPSession >> pasv: aString [
	self writeStatus: 502.
]

{ #category : #'commands-parameters' }
FTPSession >> port: aString [
	"self halt."
	self writeStatus: 502.
]

{ #category : #'accessing-reading' }
FTPSession >> process [
	^process
]

{ #category : #'commands-file-transfer' }
FTPSession >> pwd: aString [
	self write: ('257 "' , self context workingDirectory , '"').
]

{ #category : #'commands-logout' }
FTPSession >> quit: aString [
	"This command terminates a USER and if file transfer is not in progress, the server closes the control connection. If file transfer is in progress, the connection will remain open for result response and the server will then close it. If the user-process is transferring files for several USERs but does not wish to close and then reopen connections for each, then the REIN command should be used instead of QUIT.
	
	An unexpected close on the control connection will cause the server to take the effective action of an abort (ABOR) and a logout (QUIT)."

	self stop.
]

{ #category : #'commands-logout' }
FTPSession >> rein: aString [
	"This command terminates a USER, flushing all I/O and account information, except to allow any transfer in progress to be completed. All parameters are reset to the default settings and the control connection is left open. This is identical to the state in which a user finds himself immediately after the control connection is opened. A USER command may be expected to follow."
	
	self writeStatus: 502.
]

{ #category : #'commands-file-actions' }
FTPSession >> rest: aString [
	self writeStatus: 502.
]

{ #category : #'commands-file-actions' }
FTPSession >> retr: aString [
	self halt.
]

{ #category : #'commands-file-transfer' }
FTPSession >> rmd: aString [
	self writeStatus: 502.
]

{ #category : #'commands-file-transfer' }
FTPSession >> rnfr: aString [
	self writeStatus: 502.
]

{ #category : #'commands-file-transfer' }
FTPSession >> rnto: aString [
	self writeStatus: 502.
]

{ #category : #'accessing-reading' }
FTPSession >> server [
	^server
]

{ #category : #'private-server' }
FTPSession >> sessionLoop [
	[ self isConnected ]
		whileTrue: [ self sessionLoopBody ].
]

{ #category : #'private-server' }
FTPSession >> sessionLoopBody [
	self withErrorHandlerDo: [
		self withStatusHandlerDo: [
			self execute: self stream nextLineCrLf ] ].			
]

{ #category : #initialization }
FTPSession >> setSocket: aSocket server: aServer [
	socket := aSocket.
	stream := SocketStream on: aSocket.
	server := aServer.
]

{ #category : #'commands-miscellaneous' }
FTPSession >> site: aString [
	self writeStatus: 502.
]

{ #category : #'commands-login' }
FTPSession >> smnt: aString [
	"This command allows the user to mount a different file system data structure without altering his login or accounting information. Transfer parameters are similarly unchanged. The argument is a pathname specifying a directory or other system dependent file group designator."
	
	self writeStatus: 502.
]

{ #category : #'accessing-reading' }
FTPSession >> socket [
	^socket
]

{ #category : #actions }
FTPSession >> start [
	self isRunning ifTrue: [ ^self ].
	self createServer; writeWelcome.
	self process resume.
]

{ #category : #'commands-informational' }
FTPSession >> stat: aString [
	self write: self context statistics.
]

{ #category : #actions }
FTPSession >> stop [
	self isRunning ifFalse: [ ^self ].
	self process terminate.
]

{ #category : #'commands-file-actions' }
FTPSession >> stor: aString [
	self halt.
]

{ #category : #'commands-file-actions' }
FTPSession >> stou: aString [
	self writeStatus: 502.
]

{ #category : #'accessing-reading' }
FTPSession >> stream [
	^stream
]

{ #category : #'commands-parameters' }
FTPSession >> stru: aString [
	self halt.
]

{ #category : #'commands-informational' }
FTPSession >> syst: aString [
	self write: self context system.
]

{ #category : #'commands-parameters' }
FTPSession >> type: aString [

	self halt.
]

{ #category : #'commands-login' }
FTPSession >> user: aString [
	"The argument field is a Telnet string identifying the user. The user identification is that which is required by the server for access to its file system. This command will normally be the first command transmitted by the user after the control connections are made (some servers may require this). Additional identification information in the form of a password and/or an account command may also be required by some servers. Servers may allow a new USER command to be entered at any point in order to change the access control and/or accounting information. This has the effect of flushing any user, password, and account information already supplied and beginning the login sequence again. All transfer parameters are unchanged and any file transfer in progress is completed under the old access control parameters."
	
	self context username: aString.
	self writeStatus: 331.
]

{ #category : #'private-handlers' }
FTPSession >> withErrorHandlerDo: aBlock [
	aBlock
		on: Error
		do: [ :ex | self write: '500 ' , ex messageText ].
]

{ #category : #'private-handlers' }
FTPSession >> withStatusHandlerDo: aBlock [
	aBlock 
		on: FTPStatusNotification 
		do: [ :notification | 
			self write: notification asString. 
			notification resume ].
]

{ #category : #'private-writing' }
FTPSession >> write: aString [
	| command |
	Transcript show: '<< '; show: aString; cr.
	
	command := aString readStream.
	[ command atEnd ] whileFalse: [
		self stream nextPutAll: (command upTo: Character cr).
		self stream crlf; flush ].
]

{ #category : #'private-writing' }
FTPSession >> writeStatus [
	self write: '220 SqueakFtp ready yessir'.
]

{ #category : #'private-writing' }
FTPSession >> writeStatus: integer [
	self write: integer asString, ' OK'.
]

{ #category : #'private-writing' }
FTPSession >> writeWelcome [
	self write: '220 SqueakFtp ready'.
]
