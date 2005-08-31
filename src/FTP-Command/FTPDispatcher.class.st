Class {
	#name : #FTPDispatcher,
	#superclass : #FTPDirectoryContext,
	#instVars : [
		'children'
	],
	#category : 'FTP-Context'
}

{ #category : #changing }
FTPDispatcher >> add: aContext [
	^ children add: aContext.
]

{ #category : #accessing }
FTPDispatcher >> children [
	^ children
]

{ #category : #initialization }
FTPDispatcher >> initialize [
	super initialize.
	children := Set new.
]

{ #category : #changing }
FTPDispatcher >> remove: aContext [
	^ children remove: aContext.
]
