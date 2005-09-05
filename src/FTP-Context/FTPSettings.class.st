Class {
	#name : #FTPSettings,
	#superclass : #FTPProperties,
	#category : 'FTP-Server'
}

{ #category : #sockets }
FTPSettings >> backlog [
	^ self propertyAt: #backlog ifAbsent: [ 10 ].
]

{ #category : #sockets }
FTPSettings >> backlog: anInteger [
	self propertyAt: #backlog put: anInteger.
]

{ #category : #server }
FTPSettings >> context [
	^ self propertyAt: #context ifAbsent: [ FTPDispatcher new ].
]

{ #category : #server }
FTPSettings >> context: aContext [
	self propertyAt: #context put: aContext.
]

{ #category : #testing }
FTPSettings >> isLogging [
	^ self logging.
]

{ #category : #server }
FTPSettings >> logging [
	^ self propertyAt: #logging ifAbsent: [ false ].
]

{ #category : #server }
FTPSettings >> logging: aBoolean [
	self propertyAt: #logging put: aBoolean.
]

{ #category : #sockets }
FTPSettings >> port [
	^ self propertyAt: #port ifAbsent: [ 21 ].
]

{ #category : #sockets }
FTPSettings >> port: aNumber [
	self propertyAt: #port put: aNumber.
]

{ #category : #sockets }
FTPSettings >> portrange [
	^ self propertyAt: #portrange ifAbsent: [ 1024 to: 65536 ].
]

{ #category : #sockets }
FTPSettings >> portrange: anInterval [
	self propertyAt: #portrange put: anInterval.
]

{ #category : #sockets }
FTPSettings >> priority [
	^ self propertyAt: #priority ifAbsent: [ Processor userBackgroundPriority ].
]

{ #category : #sockets }
FTPSettings >> priority: aNumber [
	self propertyAt: #priority put: aNumber.
]

{ #category : #sockets }
FTPSettings >> timeout [
	^ self propertyAt: #timeout ifAbsent: [ 10 ].
]

{ #category : #sockets }
FTPSettings >> timeout: anInteger [
	self propertyAt: #timeout put: anInteger.
]
