Class {
	#name : #FTPState,
	#superclass : #Object,
	#instVars : [
		'account',
		'username',
		'password',
		'ip',
		'port',
		'passive',
		'binary'
	],
	#category : 'FTP-Server'
}

{ #category : #'accessing-authentication' }
FTPState >> account [
	^ account
]

{ #category : #'accessing-authentication' }
FTPState >> account: aString [
	account := aString
]

{ #category : #'accessing-transfer' }
FTPState >> binary [
	^ binary ifNil: [ binary := false ].
]

{ #category : #'accessing-transfer' }
FTPState >> binary: aBoolean [
	binary := aBoolean
]

{ #category : #'accessing-transfer' }
FTPState >> ip [
	^ ip
]

{ #category : #'accessing-transfer' }
FTPState >> ip: anArray [
	ip := anArray
]

{ #category : #testing }
FTPState >> isBinary [
	^ self binary.
]

{ #category : #testing }
FTPState >> isPassive [	
	^ self passive.
]

{ #category : #'accessing-transfer' }
FTPState >> passive [
	^ passive ifNil: [ passive := false ].
]

{ #category : #'accessing-transfer' }
FTPState >> passive: aBoolean [
	passive := aBoolean
]

{ #category : #'accessing-authentication' }
FTPState >> password [
	^ password
]

{ #category : #'accessing-authentication' }
FTPState >> password: aString [
	password := aString
]

{ #category : #'accessing-transfer' }
FTPState >> port [
	^ port
]

{ #category : #'accessing-transfer' }
FTPState >> port: anInteger [
	port := anInteger
]

{ #category : #'accessing-authentication' }
FTPState >> username [
	^ username
]

{ #category : #'accessing-authentication' }
FTPState >> username: aString [
	username := aString
]
