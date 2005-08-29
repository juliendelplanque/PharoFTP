Class {
	#name : #FTPNlstCommand,
	#superclass : #FTPListingCommand,
	#category : 'FTP-Command-Navigation'
}

{ #category : #accessing }
FTPNlstCommand class >> command [
	^ 'NLST'
]

{ #category : #accessing }
FTPNlstCommand >> selectors [
	^ #( printName:on: ).
]
