Class {
	#name : #FTPActiveConnection,
	#superclass : #FTPConnection,
	#category : 'FTP-Server'
}

{ #category : #actions }
FTPActiveConnection >> run: aBlock [
	aBlock ensure: [ self close ].
]
