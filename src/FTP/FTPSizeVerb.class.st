Class {
	#name : #FTPSizeVerb,
	#superclass : #FTPVerb,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPSizeVerb class >> features [
	^ self verbs.
]

{ #category : #accessing }
FTPSizeVerb class >> verbs [
	^ Array with: 'SIZE'.
]

{ #category : #processing }
FTPSizeVerb >> execute [
	| context |
	context := self findContext: self request argument.
	self return: (FTPResponse code: 213 line: context size asString).
]
