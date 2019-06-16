Class {
	#name : #FTPExternalIDEClassDefinitionContext,
	#superclass : #FTPExternalIDESourceCodeContext,
	#category : #'FTP-ExternalIDE'
}

{ #category : #'accessing-contents' }
FTPExternalIDEClassDefinitionContext >> contents [
	"Returns the content of a method formatted with OS's line ending convention."
	^ (self concernedClass definition splitOn: Character cr) joinUsing: Smalltalk os lineEnding

]

{ #category : #accessing }
FTPExternalIDEClassDefinitionContext >> name [
	^ '_class-definition.st'
]
