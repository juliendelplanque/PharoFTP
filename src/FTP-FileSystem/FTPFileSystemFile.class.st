Class {
	#name : #FTPFileSystemFile,
	#superclass : #FTPFileSystem,
	#category : #'FTP-FileSystem'
}

{ #category : #accessing }
FTPFileSystemFile >> directory [
	^ self owner.
]

{ #category : #streaming }
FTPFileSystemFile >> get: aWriteStream startingAt: anInteger [
	| stream |
	stream := self directory readOnlyFileNamed: self name. 
	[ stream binary; position: anInteger; copyInto: aWriteStream ]
		ensure: [ stream close ].
]

{ #category : #streaming }
FTPFileSystemFile >> put: aReadStream startingAt: anInteger [
	| stream |
	stream := self directory fileNamed: self name. 
	[ stream position: anInteger; copyFrom: aReadStream binary ]
		ensure: [ stream close ].
]
