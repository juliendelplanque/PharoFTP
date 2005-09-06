Class {
	#name : #FTPMockContext,
	#superclass : #FTPContext,
	#instVars : [
		'name',
		'children',
		'contents'
	],
	#category : 'FTP-Context'
}

{ #category : #accessing }
FTPMockContext >> children [
	^ children
]

{ #category : #accessing }
FTPMockContext >> children: aCollection [
	aCollection do: [ :each | each setParent: self ].
	children := aCollection.
]

{ #category : #accessing }
FTPMockContext >> contents [
	^ contents
]

{ #category : #accessing }
FTPMockContext >> contents: aString [
	contents := aString
]

{ #category : #accessing }
FTPMockContext >> name [
	^ name
]

{ #category : #accessing }
FTPMockContext >> name: aString [
	name := aString
]
