"
Journal where journal entries are stored until there is a persistent disk based store.
"
Class {
	#name : 'Journal',
	#superclass : 'Object',
	#classInstVars : [
		'id',
		'entries',
		'unposted',
		'prodId',
		'prodEntries',
		'prodUnposted',
		'underTest'
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

{ #category : 'class initialization' }
Journal class >> initialize [
	prodId := 0. 
	prodEntries := OrderedCollection new.
	prodUnposted := OrderedCollection new.
	self testStop .
"	id := prodId.
	entries := prodEntries .
	unposted := prodUnposted .
	underTest := false."
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

{ #category : 'tests' }
Journal class >> testStart [ 
	underTest := true.
	prodId := id.
	id := 0.
	entries := OrderedCollection new.
	unposted := OrderedCollection new.
	
]

{ #category : 'tests' }
Journal class >> testStop [
	underTest := false.
	id := prodId .
	entries := prodEntries .
	unposted := prodUnposted 
	
]
