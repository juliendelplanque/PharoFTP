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
FTPListCommand >> padding [
	^ #( none left right right left left none ).
]

{ #category : #accessing }
FTPListCommand >> selectors [
	^ #( permissionsOf: referencesOf: userOf: groupOf: sizeOf: timestampOf: nameOf: ).
]
