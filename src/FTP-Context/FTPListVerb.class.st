Class {
	#name : #FTPListVerb,
	#superclass : #FTPListingVerb,
	#category : 'FTP-Verbs'
}

{ #category : #accessing }
FTPListVerb class >> verbs [
	^ Array with: 'LIST'.
]

{ #category : #accessing }
FTPListVerb >> padding [
	^ #( none left right right left left none ).
]

{ #category : #accessing }
FTPListVerb >> selectors [
	^ #( permissionsOf: referencesOf: userOf: groupOf: sizeOf: timestampOf: nameOf: ).
]
