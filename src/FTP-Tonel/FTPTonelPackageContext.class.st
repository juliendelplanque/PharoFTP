Class {
	#name : #FTPTonelPackageContext,
	#superclass : #FTPTonelContext,
	#instVars : [
		'packageConcerned'
	],
	#category : #'FTP-Tonel'
}

{ #category : #'instance creation' }
FTPTonelPackageContext class >> packageConcerned: packageConcerned [ 
	^ self new
		packageConcerned: packageConcerned;
		yourself
]

{ #category : #accessing }
FTPTonelPackageContext >> children [
	^ (self packageConcerned definedClasses sorted: #name asSortFunction) collect: [ :c |
		(FTPTonelClassContext concernedClass: c)
			setParent: self;
			yourself ]
]

{ #category : #testing }
FTPTonelPackageContext >> isDirectory [
	^ true
]

{ #category : #accessing }
FTPTonelPackageContext >> name [
	^ self packageConcerned name
]

{ #category : #accessing }
FTPTonelPackageContext >> packageConcerned [
	^ packageConcerned
]

{ #category : #accessing }
FTPTonelPackageContext >> packageConcerned: anObject [
	packageConcerned := anObject
]
