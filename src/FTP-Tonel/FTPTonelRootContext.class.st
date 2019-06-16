Class {
	#name : #FTPTonelRootContext,
	#superclass : #FTPTonelContext,
	#category : #'FTP-Tonel'
}

{ #category : #accessing }
FTPTonelRootContext >> children [
	^ (RPackage organizer packages sorted: #name asSortFunction) collect: [ :p |
		(FTPPackageContext packageConcerned: p)
			classContextClass: FTPTonelClassContext;
			setParent: self;
			yourself ]
]

{ #category : #testing }
FTPTonelRootContext >> isDirectory [
	^ true
]

{ #category : #accessing }
FTPTonelRootContext >> name [
	^ '/'
]
