Class {
	#name : #FTPDirectoryContext,
	#superclass : #FTPContext,
	#category : 'FTP-Context'
}

{ #category : #convenience }
FTPDirectoryContext >> at: aString [
	^ self at: aString ifAbsent: [ self error: 'File not found.' ].
]

{ #category : #convenience }
FTPDirectoryContext >> at: aString ifAbsent: aBlock [
	^ self children
		detect: [ :each | aString = each name ]
		ifNone: aBlock.
]

{ #category : #accessing }
FTPDirectoryContext >> children [
	self subclassResponsibility.
]

{ #category : #convenience }
FTPDirectoryContext >> find: aCollection [
	aCollection isEmpty ifTrue: [ ^ self ].
	^ (self at: aCollection first ifAbsent: [ ^ nil ])
		find: aCollection allButFirst.
]

{ #category : #'accessing-information' }
FTPDirectoryContext >> help [
	^ self class comment.
]

{ #category : #testing }
FTPDirectoryContext >> isDirectoryContext [
	^ true
]

{ #category : #accessing }
FTPDirectoryContext >> size [
	^ 0
]

{ #category : #'accessing-information' }
FTPDirectoryContext >> statistics [
	^ SmalltalkImage current vmStatisticsReportString.
]

{ #category : #'accessing-information' }
FTPDirectoryContext >> system [
	^ SystemVersion current printString.
]

{ #category : #events }
FTPDirectoryContext >> unknownRequest: aRequest [
	" This message will be sent for any unknown command, sublcasses might override the default implementation to handle additional user defined verbs. "

	self session returnResponse: FTPResponse invalidCommand.
]

{ #category : #events }
FTPDirectoryContext >> updateAuthentication [
	" This message will be sent whenever a new username or password is given. "
]
