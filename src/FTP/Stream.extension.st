Extension { #name : #Stream }

{ #category : #'*FTP' }
Stream >> copyFrom: aReadStream [
	self copyFrom: aReadStream bufferSize: 1024.
]

{ #category : #'*FTP' }
Stream >> copyFrom: aReadStream bufferSize: anInteger [
	aReadStream copyInto: self bufferSize: anInteger.
]

{ #category : #'*FTP' }
Stream >> copyInto: aWriteStream [
	self copyInto: aWriteStream bufferSize: 1024.
]

{ #category : #'*FTP' }
Stream >> copyInto: aWriteStream bufferSize: anInteger [
	[ self atEnd ] 
		whileFalse: [ aWriteStream nextPutAll: (self next: anInteger) ].
		
]
