Class {
	#name : #FTPRenamedContext,
	#superclass : #FTPVirtualContext,
	#instVars : [
		'name'
	],
	#category : 'FTP-Context'
}

{ #category : #accessing }
FTPRenamedContext >> name [
	^ name
]

{ #category : #accessing }
FTPRenamedContext >> name: aString [
	name := aString
]
