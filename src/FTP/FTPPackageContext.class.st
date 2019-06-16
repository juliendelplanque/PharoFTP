Class {
	#name : #FTPPackageContext,
	#superclass : #FTPContext,
	#instVars : [
		'packageConcerned',
		'classContextClass'
	],
	#category : #'FTP-Context'
}

{ #category : #'instance creation' }
FTPPackageContext class >> packageConcerned: packageConcerned [ 
	^ self new
		packageConcerned: packageConcerned;
		yourself
]

{ #category : #accessing }
FTPPackageContext >> children [
	^ (self packageConcerned definedClasses sorted: #name asSortFunction)
		collect: [ :c | 
			(self classContextClass concernedClass: c)
				setParent: self;
				yourself ]
]

{ #category : #accessing }
FTPPackageContext >> classContextClass [
	^ classContextClass
]

{ #category : #accessing }
FTPPackageContext >> classContextClass: anObject [
	classContextClass := anObject
]

{ #category : #testing }
FTPPackageContext >> isDirectory [
	^ true
]

{ #category : #accessing }
FTPPackageContext >> name [
	^ self packageConcerned name
]

{ #category : #accessing }
FTPPackageContext >> packageConcerned [
	^ packageConcerned
]

{ #category : #accessing }
FTPPackageContext >> packageConcerned: anObject [
	packageConcerned := anObject
]
