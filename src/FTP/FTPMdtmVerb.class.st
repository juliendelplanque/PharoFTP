Class {
	#name : #FTPMdtmVerb,
	#superclass : #FTPVerb,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPMdtmVerb class >> features [
	^ self verbs.
]

{ #category : #accessing }
FTPMdtmVerb class >> verbs [
	^ Array with: 'MDTM'.
]

{ #category : #processing }
FTPMdtmVerb >> execute [
	| context |
	context := self findContext: self request argument.
	self return: (FTPResponse code: 213 line: context modification asFtpTimeStamp).
]
