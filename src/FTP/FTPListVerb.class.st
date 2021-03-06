Class {
	#name : #FTPListVerb,
	#superclass : #FTPListing,
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

{ #category : #printing }
FTPListVerb >> print: aCollection on: aStream [
	| lines sizes |
	lines := self children collect: [ :child |
		self selectors collect: [ :selector |
			String streamContents: [ :stream |
				self perform: selector with: child with: stream ] ] ].
	sizes := (1 to: self selectors size) collect: [ :index |
		lines inject: 0 into: [ :result :each |
			result max: (each at: index) size ] ].
	lines do: [ :line |
		(1 to: self selectors size) 
			do: [ :index |
				(self padding at: index) = #none
					ifTrue: [ 
						aStream nextPutAll: (line at: index) ].
				(self padding at: index) = #left
					ifTrue: [ 
						aStream nextPutAll: ((line at: index)	
							padLeftTo: (sizes at: index)
							with: Character space) ].
				(self padding at: index) = #right
					ifTrue: [ 
						aStream nextPutAll: ((line at: index)	
							padRightTo: (sizes at: index)
							with: Character space) ] ]
			separatedBy: [ aStream nextPut: Character space ].
		aStream nextPutAll: String crlf ].
]

{ #category : #accessing }
FTPListVerb >> selectors [
	^ #( printMode:on: printReferences:on: printOwner:on: printGroup:on: printSize:on: printTimestamp:on: printName:on: ).
]
