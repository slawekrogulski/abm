"
top of the command hierarchy
"
Class {
	#name : 'Action',
	#superclass : 'Object',
	#category : 'ATM-actions',
	#package : 'ATM',
	#tag : 'actions'
}

{ #category : 'testing' }
Action class >> isAbstract [

	^ self == Action
]

{ #category : 'editing keys' }
Action >> doIt: application [
	self subclassResponsibility 
]
