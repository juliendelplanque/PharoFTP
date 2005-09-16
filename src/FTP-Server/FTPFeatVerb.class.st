Class {
	#name : #FTPFeatVerb,
	#superclass : #FTPVerb,
	#category : #'FTP-Verbs'
}

{ #category : #accessing }
FTPFeatVerb class >> verbs [
	^ Array with: 'FEAT'.
]

{ #category : #processing }
FTPFeatVerb >> execute [
	self return: (FTPResponse 
		code: 211 
		string: (String streamContents: [ :stream |
			stream nextPutAll: 'Extensions supported:'; cr.
			Features asSortedCollection 
				do: [ :each | stream nextPutAll: each; cr ].
			stream nextPutAll: 'END'. ])).
]
