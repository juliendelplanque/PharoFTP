Class {
	#name : #FTPDispatcher,
	#superclass : #FTPContext,
	#instVars : [
		'children'
	],
	#category : #'FTP-Context'
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
	name := self asString.
]

{ #category : #copying }
FTPDispatcher >> postCopy [
	super postCopy.
	children := self children 
		collect: [ :each | each copy setParent: self ].
]

{ #category : #changing }
FTPDispatcher >> remove: aContext [
	^ children remove: aContext.
]
