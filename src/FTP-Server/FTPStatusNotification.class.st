Class {
	#name : #FTPStatusNotification,
	#superclass : #Notification,
	#instVars : [
		'status'
	],
	#category : 'FTP-Server'
}

{ #category : #'status-5xx' }
FTPStatusNotification class >> badCommandSequencee [
	^self status: 503 description: 'Bad sequence of commands.'
]

{ #category : #'status-5xx' }
FTPStatusNotification class >> errorInArguments [
	^self status: 501 description: 'Syntax error in arguments.'
]

{ #category : #'status-5xx' }
FTPStatusNotification class >> notImplemented [
	^self status: 502 description: 'Command not implemented.'
]

{ #category : #'status-1xx' }
FTPStatusNotification class >> okay [
	^self status: 200 description: 'Command okay.'
]

{ #category : #'instance-creation' }
FTPStatusNotification class >> status: aNumber [
	^self new
		status: aNumber;
		signal.
]

{ #category : #'instance-creation' }
FTPStatusNotification class >> status: aNumber description: aString [
	^self new
		status: aNumber;
		messageText: aString;
		signal.
]

{ #category : #'status-5xx' }
FTPStatusNotification class >> unrecognizedCommand [
	^self status: 500 description: 'Command unrecognized.'
]

{ #category : #printing }
FTPStatusNotification >> printOn: aStream [
	aStream print: self status.
	self messageText isEmptyOrNil
		ifFalse: [ aStream space; nextPutAll: self messageText ].
]

{ #category : #accessing }
FTPStatusNotification >> status [
	^status
]

{ #category : #accessing }
FTPStatusNotification >> status: aNumber [
	status := aNumber
]
