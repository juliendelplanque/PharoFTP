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

{ #category : #'accessing-information' }
FTPContext >> help [
	^ self class comment.
]

{ #category : #navigation }
FTPContext >> listDirectory [
	self subclassResponsibility.
]

{ #category : #accessing }
FTPContext >> session [
	^ FTPCurrentSession value.
]

{ #category : #'accessing-information' }
FTPContext >> statistics [
	^ SmalltalkImage current vmStatisticsReportString.
]

{ #category : #'accessing-information' }
FTPContext >> system [
	^ SmalltalkImage current vmVersion.
]

{ #category : #navigation }
FTPContext >> workingDirectory [
	self subclassResponsibility.
]
