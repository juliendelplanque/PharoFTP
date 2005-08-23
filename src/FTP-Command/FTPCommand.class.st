Class {
	#name : #FTPCommand,
	#superclass : #Object,
	#instVars : [
		'session',
		'request'
	],
	#classVars : [
		'Commands'
	],
	#category : 'FTP-Command'
}

{ #category : #accessing }
FTPCommand class >> command [
	^ nil
]

{ #category : #'instance-creation' }
FTPCommand class >> in: aSession for: aRequest ifAbsent: aBlock [
	| class |
	class := self allSubclasses
		detect: [ :each | aRequest command = each command ]
		ifNone: [ ^ aBlock value ].
	^ class new
		setSession: aSession;
		setRequest: aRequest;
		yourself.
]

{ #category : #'accessing-dynamic' }
FTPCommand >> connection [
	^ self session connection.
]

{ #category : #'accessing-dynamic' }
FTPCommand >> context [
	^ self session context.
]

{ #category : #'accessing-dynamic' }
FTPCommand >> context: aContext [
	^ self session context: aContext.
]

{ #category : #processing }
FTPCommand >> execute [
	self subclassResponsibility.
]

{ #category : #accessing }
FTPCommand >> request [
	^ request
]

{ #category : #commands }
FTPCommand >> return: aResponse [
	^ self session returnResponse: aResponse.
]

{ #category : #'accessing-dynamic' }
FTPCommand >> server [
	^ self session server.
]

{ #category : #accessing }
FTPCommand >> session [
	^ session
]

{ #category : #initialization }
FTPCommand >> setRequest: aRequest [
	request := aRequest
]

{ #category : #initialization }
FTPCommand >> setSession: aSession [
	session := aSession
]

{ #category : #'accessing-dynamic' }
FTPCommand >> state [
	^ self session state.
]
