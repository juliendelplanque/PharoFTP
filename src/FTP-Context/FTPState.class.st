Class {
	#name : #FTPState,
	#superclass : #Object,
	#instVars : [
		'username',
		'password',
		'ip',
		'port',
		'binary'
	],
	#category : 'FTP-Server'
}

{ #category : #initialization }
FTPState >> initialize [
	super initialize.
	username := password := nil.
	ip := port := nil.
	binary := false.
]
