Class {
	#name : #FTPExternalIDEClassContext,
	#superclass : #FTPExternalIDEContext,
	#instVars : [
		'concernedClass'
	],
	#category : #'FTP-ExternalIDE'
}

{ #category : #accessing }
FTPExternalIDEClassContext class >> concernedClass: concernedClass [ 
	^ self new
		concernedClass: concernedClass;
		yourself
]

{ #category : #accessing }
FTPExternalIDEClassContext >> children [
	^ Array streamContents: [ :itemsStream |
		itemsStream nextPut: (FTPExternalIDEClassDefinitionContext parent: self).
		self concernedClass methods do: [ :m |
			itemsStream nextPut: ((FTPExternalIDEMethodDefinitionContext parent: self) 
										methodSelector: m selector;
										yourself) ] ]
]

{ #category : #accessing }
FTPExternalIDEClassContext >> concernedClass [
	^ concernedClass
]

{ #category : #accessing }
FTPExternalIDEClassContext >> concernedClass: anObject [
	concernedClass := anObject
]

{ #category : #testing }
FTPExternalIDEClassContext >> isDirectory [
	^ true
]

{ #category : #accessing }
FTPExternalIDEClassContext >> name [
	^ self concernedClass name
]
