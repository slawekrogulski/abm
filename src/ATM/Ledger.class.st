"
Ledger where user accounts are stores until there is a persistent disk based storage.
"
Class {
	#name : 'Ledger',
	#superclass : 'Object',
	#classInstVars : [
		'userAccounts',
		'prodUserAccounts',
		'underTest'
	],
	#category : 'ATM-accounts',
	#package : 'ATM',
	#tag : 'accounts'
}

{ #category : 'accessing' }
Ledger class >> accountOwners [
	^userAccounts keys.
]

{ #category : 'accessing' }
Ledger class >> accountsOf: anOwner [
	^userAccounts at: anOwner 
]

{ #category : 'accessing' }
Ledger class >> add: accounts [
	userAccounts at: accounts owner put: accounts 
	
]

{ #category : 'account operations' }
Ledger class >> balanceOf: owner [
	^(self accountsOf: owner) balance
]

{ #category : 'account operations' }
Ledger class >> credit: accountId by: anAmount [
	(accountId from: self) credit: anAmount 
]

{ #category : 'account operations' }
Ledger class >> debit: accountId by: anAmount [
	(accountId from: self) debit: anAmount
]

{ #category : 'public' }
Ledger class >> exists: owner [
	^(userAccounts at: owner ifAbsent: [nil]) isNotNil
]

{ #category : 'class initialization' }
Ledger class >> initialize [ 
	userAccounts := Dictionary new.
]

{ #category : 'public' }
Ledger class >> list [
	^(userAccounts values )
]

{ #category : 'removing' }
Ledger class >> remove: owner [
	(userAccounts removeKey: owner ifAbsent: [ nil ])
	"	ifNotNil: [ 'removed all accounts for: ', owner ] 
		ifNil: [ owner,' does not have any accounts' ]
"
]
