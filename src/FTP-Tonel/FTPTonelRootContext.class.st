Class {
	#name : #FTPTonelRootContext,
	#superclass : #FTPTonelContext,
	#category : #'FTP-Tonel'
}

{ #category : #accessing }
FTPTonelRootContext >> children [
	^ (RPackage organizer packages sorted: #name asSortFunction) collect: [ :p |
		(FTPTonelPackageContext packageConcerned: p)
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
