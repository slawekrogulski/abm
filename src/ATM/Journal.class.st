"
Journal where journal entries are stored until there is a persistent disk based store.
"
Class {
	#name : 'Journal',
	#superclass : 'Object',
	#classInstVars : [
		'id',
		'entries',
		'unposted'
	],
	#category : 'ATM-accounts',
	#package : 'ATM',
	#tag : 'accounts'
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
	|je|
	je := (aJournalEntry id: id).
	entries add: je.
	unposted add: je.
]

{ #category : 'accessing' }
Journal class >> count [
	^ entries size
]

{ #category : 'class initialization' }
Journal class >> initialize [
	id := 0. 
	entries := OrderedCollection new.
	unposted := OrderedCollection new.

]

{ #category : 'accessing' }
Journal class >> list [
	^entries
]

{ #category : 'posting' }
Journal class >> nextId [ 
	id := id + 1.
	^id
]

{ #category : 'posting' }
Journal class >> post: ledger [
	[ unposted isNotEmpty ] 
		whileTrue: [ unposted removeFirst post: ledger ].
"	entries do: [ :je | je post ]"
]
