Class {
	#name : #FTPDispatcher,
	#superclass : #FTPContext,
	#instVars : [
		'children'
	],
	#category : 'FTP-Context'
}

{ #category : #changing }
FTPDispatcher >> add: aContext [
	aContext setParent: self.
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
