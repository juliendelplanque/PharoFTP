"
An ACCT request has a parameter called an account name. The client must not send an ACCT request except immediately after a PASS request.

The server may accept ACCT with code 230, meaning that permission to access files under this username has been granted; or with code 202, meaning that permission was already granted in response to USER or PASS. The server may reject ACCT with code 503 if the previous request was not PASS or with code 530 if the username, password, and account name are jointly unacceptable.
"
Class {
	#name : #FTPAcctCommand,
	#superclass : #FTPSessionCommand,
	#category : 'FTP-Command'
}

{ #category : #accessing }
FTPAcctCommand class >> command [
	^ 'ACCT'
]

{ #category : #processing }
FTPAcctCommand >> execute [
	self state account: self request argument.
	self return: (FTPResponse code: 230).
]
