Class {
	#name : #FTPInformationVerb,
	#superclass : #FTPVerb,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPInformationVerb >> contents [
	self subclassResponsibility.
]

{ #category : #processing }
FTPInformationVerb >> execute [
	self return: (FTPResponse code: self status string: self contents).
]

{ #category : #accessing }
FTPInformationVerb >> status [
	self subclassResponsibility.
]
