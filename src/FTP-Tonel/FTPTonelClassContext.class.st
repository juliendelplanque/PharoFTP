Class {
	#name : #FTPTonelClassContext,
	#superclass : #FTPTonelContext,
	#instVars : [
		'concernedClass',
		'contents'
	],
	#category : #'FTP-Tonel'
}

{ #category : #'instance creation' }
FTPTonelClassContext class >> concernedClass: concernedClass [ 
	^ self new
		concernedClass: concernedClass;
		yourself
]

{ #category : #accessing }
FTPTonelClassContext >> concernedClass [
	^ concernedClass
]

{ #category : #accessing }
FTPTonelClassContext >> concernedClass: anObject [
	concernedClass := anObject
]

{ #category : #'accessing-contents' }
FTPTonelClassContext >> contents [
	^ contents ifNil: [ contents := TonelWriter sourceCodeOf: self concernedClass ]
]

{ #category : #'accessing-contents' }
FTPTonelClassContext >> contents: aString [
	(TonelParser parseString: aString) inspect.
	self session return: FTPResponse requestedActionAborted
]

{ #category : #events }
FTPTonelClassContext >> flush [
	super flush.
	contents := nil
]

{ #category : #testing }
FTPTonelClassContext >> isDirectory [
	^ false
]

{ #category : #accessing }
FTPTonelClassContext >> name [
	^ self concernedClass name
]

{ #category : #accessing }
FTPTonelClassContext >> size [
	^ self contents size
]
