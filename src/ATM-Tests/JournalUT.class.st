"
subclass for verifying Journal
"
Class {
	#name : 'JournalUT',
	#superclass : 'Journal',
	#classTraits : 'Tester',
	#classInstVars : [
		'prodId',
		'prodEntries',
		'prodUnposted',
		'underTest'
	],
	#category : 'ATM-Tests-UT extensions',
	#package : 'ATM-Tests',
	#tag : 'UT extensions'
}

{ #category : 'adding' }
JournalUT class >> add: journalEntry [
	journalEntry tester: tester .
	super add: journalEntry .
]

{ #category : 'verification' }
JournalUT class >> allPosted [
	entries do: [ :e | tester assert: e posted ].
]

{ #category : 'verification' }
JournalUT class >> entryCountIs: aCount [
	tester assert: self count equals: aCount 
]

{ #category : 'accessing' }
JournalUT class >> first [
	^ entries first
]

{ #category : 'verification' }
JournalUT class >> nonePosted [
	entries do: [ :e | tester deny: e posted ].
]

{ #category : 'verification' }
JournalUT class >> nonePostedAfter: anId [
	entries do: [ :e |
		(e id > anId)
			ifTrue: [ tester deny: e posted ]  ].
]

{ #category : 'accessing' }
JournalUT class >> second [
	^ entries second
]

{ #category : 'tests' }
JournalUT class >> testStart [ 
	underTest := true.
	prodId := id.
	prodEntries := entries.
	prodUnposted := unposted .
	self initialize.
"	id := 0.
	entries := OrderedCollection new.
	unposted := OrderedCollection new.
"
]

{ #category : 'tests' }
JournalUT class >> testStop [
	underTest := false.
	id := prodId .
	entries := prodEntries .
	unposted := prodUnposted 
	
]

{ #category : 'accessing' }
JournalUT class >> third [
	^ entries third
]
