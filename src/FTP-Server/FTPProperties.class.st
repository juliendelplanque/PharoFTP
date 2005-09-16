Class {
	#name : #FTPProperties,
	#superclass : #Object,
	#instVars : [
		'properties'
	],
	#category : #'FTP-Server'
}

{ #category : #initialization }
FTPProperties >> initialize [
	super initialize.
	properties := IdentityDictionary new.
]

{ #category : #copying }
FTPProperties >> postCopy [
	super postCopy.
	properties := self properties copy.
]

{ #category : #accessing }
FTPProperties >> properties [
	^ properties
]

{ #category : #accessing }
FTPProperties >> propertyAt: aSymbol [
	^ self properties at: aSymbol.
]

{ #category : #accessing }
FTPProperties >> propertyAt: aSymbol ifAbsent: aBlock [
	^ self properties at: aSymbol ifAbsent: aBlock.
]

{ #category : #accessing }
FTPProperties >> propertyAt: aSymbol put: anObject [
	^ self properties at: aSymbol put: anObject.
]
