Class {
	#name : #FTPListener,
	#superclass : #Object,
	#instVars : [
		'process',
		'listener'
	],
	#category : #'FTP-Server'
}

{ #category : #'accessing-settings' }
FTPListener >> backlog [
	self subclassResponsibility.
]

{ #category : #private }
FTPListener >> buildListener [
	^ Socket newTCP
		listenOn: self port backlogSize: self backlog;
		yourself.
]

{ #category : #listening }
FTPListener >> createListener [
	Socket initializeNetwork.
	listener := self buildListener.
]

{ #category : #listening }
FTPListener >> destroyListener [
	self listener isNil
		ifFalse: [ self listener destroy ].
]

{ #category : #actions }
FTPListener >> handle: aSocket [
	self subclassResponsibility.
]

{ #category : #listening }
FTPListener >> listen [
	[ self createListener; listenLoop ] 
		ensure: [ self destroyListener ].
]

{ #category : #listening }
FTPListener >> listenCycle [
	| socket | 
	self listener isValid
		ifFalse: [ self destroyListener; createListener ].
	socket := self listener 
		waitForAcceptFor: self timeout 
		ifTimedOut: [ nil ].
	socket isNil ifTrue: [ ^ self ].
	socket isConnected
		ifTrue: [ self handle: socket ]
		ifFalse: [ socket destroy ].
]

{ #category : #listening }
FTPListener >> listenLoop [
	[ self listenCycle ] repeat.
]

{ #category : #accessing }
FTPListener >> listener [
	^ listener
]

{ #category : #'accessing-settings' }
FTPListener >> name [
	self subclassResponsibility.
]

{ #category : #'accessing-settings' }
FTPListener >> port [
	self subclassResponsibility.
]

{ #category : #printing }
FTPListener >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' port: '; print: self port.
]

{ #category : #'accessing-settings' }
FTPListener >> priority [
	self subclassResponsibility.
]

{ #category : #accessing }
FTPListener >> process [
	^ process
]

{ #category : #actions }
FTPListener >> start [
	process := [ self listen ] 
		forkAt: self priority
		named: self name.
]

{ #category : #actions }
FTPListener >> stop [
	process terminate.
]

{ #category : #'accessing-settings' }
FTPListener >> timeout [
	self subclassResponsibility.
]
