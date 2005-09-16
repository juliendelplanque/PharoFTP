Class {
	#name : #FTPInformation,
	#superclass : #FTPVerb,
	#category : #'FTP-Verbs'
}

{ #category : #accessing }
FTPInformation >> contents [
	self subclassResponsibility.
]

{ #category : #processing }
FTPInformation >> execute [
	self return: (FTPResponse code: self status string: self contents).
]

{ #category : #accessing }
FTPInformation >> status [
	self subclassResponsibility.
]
