Class {
	#name : #FTPTelnetConnection,
	#superclass : #FTPConnection,
	#instVars : [
		'process'
	],
	#category : 'FTP-Server'
}

{ #category : #'instance creation' }
FTPTelnetConnection class >> on: aSocket do: aBlock [
	^ (self on: aSocket)
		do: aBlock;
		yourself.
]

{ #category : #actions }
FTPTelnetConnection >> close [
	super close.
	self isRunning
		ifTrue: [ self process terminate ].
]

{ #category : #testing }
FTPTelnetConnection >> isRunning [
	^ self process notNil and: [ self process isTerminated not ].
]

{ #category : #accessing }
FTPTelnetConnection >> process [
	^ process
]

{ #category : #actions }
FTPTelnetConnection >> run: aBlock [
	process := [ super run: aBlock ] 
		fork.
]
