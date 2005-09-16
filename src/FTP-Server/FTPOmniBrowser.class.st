Class {
	#name : #FTPOmniBrowser,
	#superclass : #FTPContext,
	#instVars : [
		'filter',
		'node',
		'children'
	],
	#category : #'FTP-Context-Experimental'
}

{ #category : #'instance-creation' }
FTPOmniBrowser class >> parent: aContext node: aNode [
	^ self parent: aContext node: aNode metaNode: aNode metaNode.
]

{ #category : #'instance-creation' }
FTPOmniBrowser class >> parent: aContext node: aNode metaNode: aMetaNode [
	^ (self parent: aContext)
		setNode: aNode;
		setMetaNode: aMetaNode;
		yourself.
]

{ #category : #accessing }
FTPOmniBrowser >> children [
	^ children ifNil: [
		children := (self filter nodesForParent: self node)
			collect: [ :each | self species parent: self node: each ] ].
]

{ #category : #private }
FTPOmniBrowser >> filter [
	^ filter
]

{ #category : #private }
FTPOmniBrowser >> metaNode [
	^ filter metaNode
]

{ #category : #accessing }
FTPOmniBrowser >> name [
	^ self node name. 
]

{ #category : #private }
FTPOmniBrowser >> node [
	^ node
]

{ #category : #initialization }
FTPOmniBrowser >> setMetaNode: aMetaNode [
	filter := aMetaNode filter monitor: self.
]

{ #category : #initialization }
FTPOmniBrowser >> setNode: aNode [
	node := aNode
]
