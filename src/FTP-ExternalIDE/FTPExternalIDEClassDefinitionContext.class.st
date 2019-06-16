Class {
	#name : #FTPExternalIDEClassDefinitionContext,
	#superclass : #FTPExternalIDESourceCodeContext,
	#category : #'FTP-ExternalIDE'
}

{ #category : #'accessing-contents' }
FTPExternalIDEClassDefinitionContext >> contents [
	^ (self concernedClass definition splitOn: Character cr) joinUsing: Smalltalk os lineEnding
]

{ #category : #accessing }
FTPExternalIDEClassDefinitionContext >> name [
	^ 'class-definition.st'
]
