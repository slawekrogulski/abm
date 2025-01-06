Class {
	#name : 'Accounts',
	#superclass : 'Object',
	#classInstVars : [
		'accounts'
	],
	#category : 'ATM',
	#package : 'ATM'
}

{ #category : 'as yet unclassified' }
Accounts class >> accountNames [
	^(accounts) keys.
]

{ #category : 'adding' }
Accounts class >> addCashAccountFor: userName [
	(self cash) at: userName ifAbsentPut: Account new.
]

{ #category : 'as yet unclassified' }
Accounts class >> balanceFor: userName [
	^((accounts at: userName) at: #cash) balance
]

{ #category : 'as yet unclassified' }
Accounts class >> deposit: anAmount to: usertName [
	(self cash at: usertName) credit: anAmount 
]

{ #category : 'accessing' }
Accounts class >> for: accountOwner [
	^accounts at: accountOwner 
]

{ #category : 'class initialization' }
Accounts class >> initialize [
	accounts := Dictionary new. 
"	accounts at: #cash put: Dictionary new.
	accounts at: #payable put: Dictionary new .
	accounts at: #receivable put: Dictionary new.
"	
]

{ #category : 'initialization' }
Accounts class >> initializeFor: loggedInUser [
	accounts at: loggedInUser ifAbsentPut: [ 
		Dictionary new
			at: #cash put: Account new;
			at: #payable put: Dictionary new;
			at: #receivable put: Dictionary new;
			yourself ] .
	
	
]

{ #category : 'accessing' }
Accounts class >> list [ 
	^accounts 
]

{ #category : 'as yet unclassified' }
Accounts class >> payableFor: owner [
	^((accounts at: owner) at: #payable) associations 
]

{ #category : 'public' }
Accounts class >> post: aJournalEntry [
	|account|
	account := (accounts at: (aJournalEntry accountName )) at: (aJournalEntry accountType ).
	account selector: (aJournalEntry operation) argument: (aJournalEntry amount) .
	aJournalEntry postTo: account. 
	
]

{ #category : 'as yet unclassified' }
Accounts class >> receivableFor: owner [
	^((accounts at: owner) at: #receivable) associations 
]

{ #category : 'removing' }
Accounts class >> remove: accountName [
	(accounts at: #cash) removeKey: accountName 
]

{ #category : 'as yet unclassified' }
Accounts class >> retrieve: accountName accountType: accountType [
	(accountType = #cash) ifTrue: [ 
		(accounts at: accountName) at: #cash ]
]

{ #category : 'as yet unclassified' }
Accounts class >> transfer: anAmount from: sender to: recipient [ 
	|senderAccount recipientAccount|
	senderAccount := self cash at: sender.
	recipientAccount:= self cash at: recipient .
	senderAccount debit: anAmount .
	recipientAccount credit: anAmount. 
]
