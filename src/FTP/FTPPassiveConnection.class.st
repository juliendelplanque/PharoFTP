Class {
	#name : #FTPPassiveConnection,
	#superclass : #FTPSessionStream,
	#category : #'FTP-Server'
}

{ #category : #'instance creation' }
FTPPassiveConnection class >> on: aSocket do: aBlock [
	^ (self on: aSocket)
		do: aBlock;
		yourself.
]

{ #category : #actions }
FTPPassiveConnection >> close [
	super close.
	self process isTerminated 
		ifFalse: [ self process terminate ].
]

{ #category : #accessing }
FTPPassiveConnection >> process [
	^ process
]

{ #category : #actions }
FTPPassiveConnection >> run: aBlock [
	process := [ super run: aBlock ] 
		fork.
]
