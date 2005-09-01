Class {
	#name : #FTPState,
	#superclass : #FTPProperties,
	#category : 'FTP-Server'
}

{ #category : #authentication }
FTPState >> account [
	^ self propertyAt: #account ifAbsent: [ String new ].
]

{ #category : #authentication }
FTPState >> account: aString [
	self propertyAt: #account put: aString.
]

{ #category : #mode }
FTPState >> binary [
	^ self propertyAt: #binary ifAbsent: [ false ].
]

{ #category : #mode }
FTPState >> binary: aBoolean [
	self propertyAt: #binary put: aBoolean.
]

{ #category : #address }
FTPState >> ip [
	^ self propertyAt: #ip ifAbsent: [ #( 127 0 0 1 ) ].
]

{ #category : #address }
FTPState >> ip: anArray [
	self propertyAt: #ip put: anArray.
]

{ #category : #testing }
FTPState >> isBinary [
	^ self binary.
]

{ #category : #testing }
FTPState >> isPassive [	
	^ self passive.
]

{ #category : #mode }
FTPState >> passive [
	^ self propertyAt: #passive ifAbsent: [ false ].
]

{ #category : #mode }
FTPState >> passive: aBoolean [
	self propertyAt: #passive put: aBoolean.
]

{ #category : #authentication }
FTPState >> password [
	^ self propertyAt: #password ifAbsent: [ String new ].
]

{ #category : #authentication }
FTPState >> password: aString [
	self propertyAt: #password put: aString.
]

{ #category : #address }
FTPState >> port [
	^ self propertyAt: #port ifAbsent: [ 20 ].
]

{ #category : #address }
FTPState >> port: anInteger [
	self propertyAt: #port put: anInteger.
]

{ #category : #transfer }
FTPState >> position [
	^ self propertyAt: #position ifAbsent: [ 0 ].
]

{ #category : #transfer }
FTPState >> position: anInteger [
	self propertyAt: #position put: anInteger.
]

{ #category : #authentication }
FTPState >> username [
	^ self propertyAt: #username ifAbsent: [ String new ].
]

{ #category : #authentication }
FTPState >> username: aString [
	self propertyAt: #username put: aString.
]
