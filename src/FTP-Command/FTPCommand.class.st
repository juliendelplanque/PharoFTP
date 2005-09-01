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

{ #category : #accessing }
FTPCommand >> context [
	^ self session context.
]

{ #category : #accessing }
FTPCommand >> context: aContext [
	^ self session context: aContext.
]

{ #category : #processing }
FTPCommand >> execute [
	self subclassResponsibility.
]

{ #category : #conveniance }
FTPCommand >> findContext: aString [
	^ self findContext: aString type: nil.
]

{ #category : #conveniance }
FTPCommand >> findContext: aString type: aSelector [
	| target invalid |
	target := self context lookup: aString.
	invalid := target isNil 
		or: [ aSelector == #file and: [ target isFile not ] ]
		or: [ aSelector == #directory and: [ target isDirectory not ] ].
	invalid ifTrue: [ self return: FTPResponse notFound ].
	^ target.
]

{ #category : #'accessing-readonly' }
FTPCommand >> request [
	^ request
]

{ #category : #actions }
FTPCommand >> response: aResponse [
	self session response: aResponse.
]

{ #category : #actions }
FTPCommand >> return: aResponse [
	self session return: aResponse.
]

{ #category : #'accessing-readonly' }
FTPCommand >> server [
	^ self session server.
]

{ #category : #'accessing-readonly' }
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

{ #category : #'accessing-readonly' }
FTPCommand >> state [
	^ self session state.
]
