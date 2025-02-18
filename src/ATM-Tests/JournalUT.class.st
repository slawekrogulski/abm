"
subclass for verifying Journal
"
Class {
	#name : 'JournalUT',
	#superclass : 'Journal',
	#classTraits : 'Tester',
	#category : 'ATM-Tests',
	#package : 'ATM-Tests'
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

{ #category : 'accessing' }
JournalUT class >> third [
	^ entries third
]
