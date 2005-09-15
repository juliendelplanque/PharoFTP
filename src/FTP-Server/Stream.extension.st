Extension { #name : #Stream }

{ #category : #'*ftp' }
Stream >> copyFrom: aReadStream [
	self copyFrom: aReadStream bufferSize: 1024.
]

{ #category : #'*ftp' }
Stream >> copyFrom: aReadStream bufferSize: anInteger [
	aReadStream copyInto: self bufferSize: anInteger.
]

{ #category : #'*ftp' }
Stream >> copyInto: aWriteStream [
	self copyInto: aWriteStream bufferSize: 1024.
]

{ #category : #'*ftp' }
Stream >> copyInto: aWriteStream bufferSize: anInteger [
	[ self atEnd ] 
		whileFalse: [ aWriteStream nextPutAll: (self next: anInteger) ].
		
]
