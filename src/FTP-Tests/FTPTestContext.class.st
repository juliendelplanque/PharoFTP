Class {
	#name : #FTPTestContext,
	#superclass : #FTPContext,
	#instVars : [
		'name',
		'children',
		'contents'
	],
	#category : #'FTP-Tests'
}

{ #category : #accessing }
FTPTestContext >> children [
	^ children
]

{ #category : #accessing }
FTPTestContext >> children: aCollection [
	aCollection do: [ :each | each setParent: self ].
	children := aCollection.
]

{ #category : #accessing }
FTPTestContext >> contents [
	^ contents
]

{ #category : #accessing }
FTPTestContext >> contents: aString [
	contents := aString
]

{ #category : #accessing }
FTPTestContext >> name [
	^ name
]

{ #category : #accessing }
FTPTestContext >> name: aString [
	name := aString
]
