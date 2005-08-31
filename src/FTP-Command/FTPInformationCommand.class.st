Class {
	#name : #FTPInformationCommand,
	#superclass : #FTPCommand,
	#category : 'FTP-Command-Information'
}

{ #category : #accessing }
FTPInformationCommand >> contents [
	self subclassResponsibility.
]

{ #category : #processing }
FTPInformationCommand >> execute [
	self return: (FTPResponse code: self status string: self contents).
]

{ #category : #accessing }
FTPInformationCommand >> status [
	self subclassResponsibility.
]
