Class {
	#name : #FTPContext,
	#superclass : #Object,
	#category : 'FTP-Server'
}

{ #category : #'instance creation' }
FTPContext class >> on: aConnection [
	^self new
		connection: aConnection;
		yourself.
]

{ #category : #private }
FTPContext >> errorInvalidCommand [
	^self error: 'Invalid command'
]

{ #category : #'accessing-information' }
FTPContext >> help [
	^self class comment.
]

{ #category : #actions }
FTPContext >> password: aString [
]

{ #category : #'accessing-information' }
FTPContext >> statistics [
	^SmalltalkImage current vmStatisticsReportString.
]

{ #category : #'accessing-information' }
FTPContext >> system [
	^SmalltalkImage current vmVersion.
]

{ #category : #actions }
FTPContext >> username: aString [
]
