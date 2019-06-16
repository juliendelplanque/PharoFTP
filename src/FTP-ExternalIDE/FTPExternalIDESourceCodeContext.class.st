Class {
	#name : #FTPExternalIDESourceCodeContext,
	#superclass : #FTPExternalIDEContext,
	#category : #'FTP-ExternalIDE'
}

{ #category : #accessing }
FTPExternalIDESourceCodeContext >> concernedClass [
	^ self parent concernedClass
]

{ #category : #'accessing-contents' }
FTPExternalIDESourceCodeContext >> isDirectory [
	^ false
]

{ #category : #'accessing-contents' }
FTPExternalIDESourceCodeContext >> size [
	^ self contents size
]
