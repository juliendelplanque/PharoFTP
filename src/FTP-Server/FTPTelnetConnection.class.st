Class {
	#name : #FTPTelnetConnection,
	#superclass : #FTPSessionStream,
	#instVars : [
		'process'
	],
	#category : #'FTP-Server'
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
	process := [ aBlock ensure: [ self session close ] ]
		forkAt: self settings priority
		named: (self settings 
			nameFor: 'session').
]
