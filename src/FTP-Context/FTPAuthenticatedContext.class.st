Class {
	#name : #FTPAuthenticatedContext,
	#superclass : #FTPContext,
	#instVars : [
		'username',
		'password'
	],
	#category : 'FTP-Context'
}

{ #category : #accessing }
FTPAuthenticatedContext >> password [
	^ password
]

{ #category : #accessing }
FTPAuthenticatedContext >> password: aString [
	password := aString
]

{ #category : #accessing }
FTPAuthenticatedContext >> username [
	^ username
]

{ #category : #accessing }
FTPAuthenticatedContext >> username: aString [
	username := aString
]
