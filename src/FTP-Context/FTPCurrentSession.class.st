Class {
	#name : #FTPCurrentSession,
	#superclass : #Notification,
	#category : 'FTP-Server'
}

{ #category : #'as yet unclassified' }
FTPCurrentSession class >> use: aSession during: aBlock [
	^ aBlock on: self do: [ :n | n resume: aSession ].
]

{ #category : #'as yet unclassified' }
FTPCurrentSession class >> value [
	^ self signal
]
