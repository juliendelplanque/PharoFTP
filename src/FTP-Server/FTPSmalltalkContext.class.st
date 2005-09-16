Class {
	#name : #FTPSmalltalkContext,
	#superclass : #FTPContext,
	#instVars : [
		'actualClass'
	],
	#category : #'FTP-Context'
}

{ #category : #accessing }
FTPSmalltalkContext >> actualClass [ 
	^ actualClass ifNil: [ actualClass := ProtoObject ].
]

{ #category : #initialization }
FTPSmalltalkContext >> setActualClass: aClass [
	actualClass := aClass
]
