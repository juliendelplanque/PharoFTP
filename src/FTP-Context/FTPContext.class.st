Class {
	#name : #FTPContext,
	#superclass : #Object,
	#category : 'FTP-Server'
}

{ #category : #navigation }
FTPContext >> changeDirectoryTo: aString [
	self subclassResponsibility.
]

{ #category : #navigation }
FTPContext >> changeDirectoryToParent [
	self subclassResponsibility.
]

{ #category : #private }
FTPContext >> errorInvalidCommand [
	^self error: 'Invalid command'
]

{ #category : #'accessing-information' }
FTPContext >> help [
	^ self class comment.
]

{ #category : #navigation }
FTPContext >> listDirectory [
	self subclassResponsibility.
]

{ #category : #actions }
FTPContext >> password: aString [
]

{ #category : #accessing }
FTPContext >> session [
	^ FTPCurrentSession value.
]

{ #category : #'initialize-release' }
FTPContext >> setSession: aSession [
	session := aSession
]

{ #category : #'accessing-information' }
FTPContext >> statistics [
	^ SmalltalkImage current vmStatisticsReportString.
]

{ #category : #'accessing-information' }
FTPContext >> system [
	^ SmalltalkImage current vmVersion.
]

{ #category : #actions }
FTPContext >> username: aString [
]

{ #category : #navigation }
FTPContext >> workingDirectory [
	self subclassResponsibility.
]