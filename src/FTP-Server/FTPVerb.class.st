Class {
	#name : #FTPVerb,
	#superclass : #Object,
	#instVars : [
		'session',
		'request'
	],
	#classVars : [
		'Features',
		'Verbs'
	],
	#category : #'FTP-Verbs'
}

{ #category : #accessing }
FTPVerb class >> features [
	" Return a list of features of the receiver, this method will be queried from the FEAT command. "
	
	^ #()
]

{ #category : #'instance-creation' }
FTPVerb class >> in: aSession for: aRequest ifAbsent: aBlock [
	| class |
	class := Verbs
		at: aRequest verb
		ifAbsent: [ ^ aBlock value ].
	^ class new
		setSession: aSession;
		setRequest: aRequest;
		yourself.
]

{ #category : #initialization }
FTPVerb class >> initialize [
	" FTPVerb initialize "

	self initializeVerbs.
	self initializeFeatures.
]

{ #category : #initialization }
FTPVerb class >> initializeFeatures [
	Features := Set new.
	self withAllSubclassesDo: [ :class |
		Features addAll: class features ].
]

{ #category : #initialization }
FTPVerb class >> initializeVerbs [
	Verbs := Dictionary new.
	self withAllSubclassesDo: [ :class |
		class verbs do: [ :verb |
			Verbs at: verb put: class ] ].
]

{ #category : #accessing }
FTPVerb class >> verbs [
	" Return a collection of upper-case command strings (verbs), where the receiver should be used with. "
	
	^ #()
]

{ #category : #accessing }
FTPVerb >> context [
	^ self session context.
]

{ #category : #accessing }
FTPVerb >> context: aContext [
	^ self session context: aContext.
]

{ #category : #processing }
FTPVerb >> execute [
	self subclassResponsibility.
]

{ #category : #conveniance }
FTPVerb >> findContext: aString [
	^ self findContext: aString type: nil.
]

{ #category : #conveniance }
FTPVerb >> findContext: aString type: aSelector [
	^ self findContext: aString type: aSelector new: false.
]

{ #category : #conveniance }
FTPVerb >> findContext: aString type: aSelector new: aBoolean [
	| target invalid |
	target := self context lookup: aString.
	(target isNil and: [ aBoolean ]) ifTrue: [
		self context canCreate
			ifFalse: [ self return: FTPResponse permissionDenied ]. 
		target := aSelector caseOf: {
			[ #file ] -> [ self context createFileNamed: aString ].
			[ #directory ] -> [ self context createDirectoryNamed: aString ].
		} ].
	invalid := target isNil
		or: [ aSelector == #file and: [ target isFile not ] ]
		or: [ aSelector == #directory and: [ target isDirectory not ] ].
	invalid ifTrue: [ self return: FTPResponse notFound ].
	^ target.
]

{ #category : #'accessing-readonly' }
FTPVerb >> request [
	^ request
]

{ #category : #actions }
FTPVerb >> response: aResponse [
	self session response: aResponse.
]

{ #category : #actions }
FTPVerb >> return: aResponse [
	self session return: aResponse.
]

{ #category : #'accessing-readonly' }
FTPVerb >> server [
	^ self session server.
]

{ #category : #'accessing-readonly' }
FTPVerb >> session [
	^ session
]

{ #category : #initialization }
FTPVerb >> setRequest: aRequest [
	request := aRequest
]

{ #category : #initialization }
FTPVerb >> setSession: aSession [
	session := aSession
]

{ #category : #'accessing-readonly' }
FTPVerb >> settings [
	^ self server settings.
]

{ #category : #'accessing-readonly' }
FTPVerb >> state [
	^ self session state.
]
