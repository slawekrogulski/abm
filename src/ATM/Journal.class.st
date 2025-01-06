Class {
	#name : 'Journal',
	#superclass : 'Object',
	#classInstVars : [
		'id',
		'entries'
	],
	#category : 'ATM',
	#package : 'ATM'
}

{ #category : 'adding' }
Journal class >> add: aJournalEntry [
	self nextId .
	aJournalEntry isArray 
		ifFalse: [ self addWithId: aJournalEntry]
		ifTrue: [aJournalEntry do: [ :je | self addWithId: je]].
]

{ #category : 'adding' }
Journal class >> addWithId: aJournalEntry [
	entries add: (aJournalEntry id: id)
]

{ #category : 'accessing' }
Journal class >> entriesFor: loggedInUser [
	^(entries select: [ :e | e owner = loggedInUser ]) asArray
]

{ #category : 'class initialization' }
Journal class >> initialize [ 
	id := 0.
	entries := OrderedCollection new.
]

{ #category : 'accessing' }
Journal class >> list [
	^entries
]

{ #category : 'accessing' }
Journal class >> nextId [ 
	id := id + 1.
	^id
]

{ #category : 'as yet unclassified' }
Journal class >> postFor: owner [
	(entries select: [ :e | e owner = owner] ) do: [ :e | 
		e postTo: (e retrieveAccountFrom: Accounts)  ]
]
