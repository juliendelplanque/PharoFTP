Class {
	#name : #FTPFileContext,
	#superclass : #FTPContext,
	#category : 'FTP-Context'
}

{ #category : #accessing }
FTPFileContext >> contents [
	self subclassResponsibility.
]

{ #category : #accessing }
FTPFileContext >> contents: aString [
	self subclassResponsibility.
]

{ #category : #convenience }
FTPFileContext >> find: aCollection [
	^ aCollection isEmpty ifTrue: [ self ].
]

{ #category : #testing }
FTPFileContext >> isDirectory [
	^ false
]

{ #category : #'accessing-dynamic' }
FTPFileContext >> size [
	^ self contents size.
]
