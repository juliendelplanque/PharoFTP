Class {
	#name : #FTPForkedConnection,
	#superclass : #FTPConnection,
	#instVars : [
		'process'
	],
	#category : 'FTP-Server'
}

{ #category : #'instance creation' }
FTPForkedConnection class >> on: aSocket do: aBlock [
	^ (self on: aSocket)
		do: aBlock;
		yourself.
]

{ #category : #actions }
FTPForkedConnection >> close [
	super close.
	self isRunning
		ifTrue: [ self process terminate ].
]

{ #category : #testing }
FTPForkedConnection >> isRunning [
	^ self process notNil and: [ self process isTerminated not ].
]

{ #category : #accessing }
FTPForkedConnection >> process [
	^ process
]

{ #category : #actions }
FTPForkedConnection >> run: aBlock [
	process := [ super run: aBlock ] 
		fork.
]
