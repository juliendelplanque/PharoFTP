Class {
	#name : #FTPListCommand,
	#superclass : #FTPListingCommand,
	#category : 'FTP-Command-Navigation'
}

{ #category : #accessing }
FTPListCommand class >> command [
	^ 'LIST' 
]

{ #category : #accessing }
FTPListCommand >> selectors [
	^ #( printPermission:on: printReferences:on: printUser:on: printGroup:on: printSize:on: printTimestamp:on: printName:on: ).
]
