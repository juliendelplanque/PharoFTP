Class {
	#name : #FTPExternalIDEMethodDefinitionContext,
	#superclass : #FTPExternalIDESourceCodeContext,
	#instVars : [
		'methodSelector'
	],
	#category : #'FTP-ExternalIDE'
}

{ #category : #accessing }
FTPExternalIDEMethodDefinitionContext >> compiledMethod [
	^ self concernedClass >> self methodSelector
]

{ #category : #'accessing-contents' }
FTPExternalIDEMethodDefinitionContext >> contents [
	^ (self compiledMethod sourceCode splitOn: Character cr) joinUsing: Smalltalk os lineEnding
]

{ #category : #'accessing-contents' }
FTPExternalIDEMethodDefinitionContext >> contents: aString [
	self flag: #TODO. "Change so it works on other os than MacOS (windows uses CRLF for line ending)."
	self concernedClass compile: (aString replaceAll: Character lf with: Character cr)
]

{ #category : #accessing }
FTPExternalIDEMethodDefinitionContext >> methodSelector [
	^ methodSelector
]

{ #category : #accessing }
FTPExternalIDEMethodDefinitionContext >> methodSelector: anObject [
	methodSelector := anObject
]

{ #category : #'accessing-contents' }
FTPExternalIDEMethodDefinitionContext >> name [
	^ (self methodSelector asString replaceAll: $: with: $_) , '.st'
]
