Class {
	#name : #FTPPassiveConnection,
	#superclass : #FTPConnection,
	#instVars : [
		'process'
	],
	#category : 'FTP-Server'
}

{ #category : #'instance creation' }
FTPPassiveConnection class >> on: aSocket do: aBlock [
	^ (self on: aSocket)
		do: aBlock;
		yourself.
]

{ #category : #actions }
FTPPassiveConnection >> close [
	process terminate.
	super close.
]

{ #category : #actions }
FTPPassiveConnection >> run: aBlock [
	process := [ 
		self socket waitForConnectionFor: 60.
		aBlock ensure: [ self close ] ] fork.
]
