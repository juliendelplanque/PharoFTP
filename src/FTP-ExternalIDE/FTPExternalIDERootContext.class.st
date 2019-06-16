Class {
	#name : #FTPExternalIDERootContext,
	#superclass : #FTPExternalIDEContext,
	#category : #'FTP-ExternalIDE'
}

{ #category : #accessing }
FTPExternalIDERootContext >> children [
	^ (RPackage organizer packages sorted: #name asSortFunction) collect: [ :p |
		(FTPPackageContext packageConcerned: p)
			classContextClass: FTPExternalIDEClassContext;
			setParent: self;
			yourself ]
]

{ #category : #accessing }
FTPExternalIDERootContext >> isDirectory [
	^ true
]

{ #category : #accessing }
FTPExternalIDERootContext >> name [
	^ '/'
]
