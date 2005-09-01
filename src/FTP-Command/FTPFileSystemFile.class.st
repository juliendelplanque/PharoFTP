Class {
	#name : #FTPFileSystemFile,
	#superclass : #FTPFileSystem,
	#category : 'FTP-Context'
}

{ #category : #'accessing-internal' }
FTPFileSystemFile >> directory [
	^ self owner.
]

{ #category : #streaming }
FTPFileSystemFile >> get: aWriteStream startingAt: anInteger [
	| stream |
	stream := self directory readOnlyFileNamed: self name. 
	[ aWriteStream nextPutAll: (stream position: anInteger; upToEnd) ]
		ensure: [ stream close ].
]

{ #category : #streaming }
FTPFileSystemFile >> put: aReadStream startingAt: anInteger [
	| stream |
	stream := self directory fileNamed: self name. 
	[ stream position: anInteger; nextPutAll: aReadStream upToEnd ]
		ensure: [ stream close ].
]
