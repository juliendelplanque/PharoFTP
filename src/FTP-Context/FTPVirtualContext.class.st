Class {
	#name : #FTPVirtualContext,
	#superclass : #ProtoObject,
	#instVars : [
		'context'
	],
	#category : 'FTP-Context'
}

{ #category : #'instance-creation' }
FTPVirtualContext class >> on: aContext [
	^ self new 	
		setContext: aContext; 
		yourself.
]

{ #category : #accessing }
FTPVirtualContext >> context [
	^ context
]

{ #category : #private }
FTPVirtualContext >> doesNotUnderstand: aMessage [
	| result |
	result := self context 
		perform: aMessage selector 
		withArguments: aMessage arguments.
	^ self context == result
		ifFalse: [ result ]
		ifTrue: [ self ].
]

{ #category : #initialization }
FTPVirtualContext >> setContext: aContext [
	context := aContext
]
