"
comment
"
Class {
	#name : 'UserAccountPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'payables',
		'receivables',
		'userAccounts',
		'cashAtBankBalanceText',
		'cashOnHandBalanceText',
		'accountBalances'
	],
	#category : 'ATM-ui',
	#package : 'ATM',
	#tag : 'ui'
}

{ #category : 'layout' }
UserAccountPresenter >> defaultLayout [ 
	|payablePresenter receivablePresenter  balanceLayout nonCash balanceConstraint|
	balanceConstraint := [:constraint|
		"constraint expand: true."
		constraint padding: 0.
		constraint height: 80. 
		constraint width: 10.
		constraint fill: true.].
	balanceLayout := self newBoxLayoutTopToBottom 
		add: accountBalances expand: true fill: true padding: 10;
		yourself.
	payablePresenter := self newBoxLayoutTopToBottom
		add: 'Payable' expand: false; 
		add: payables  expand: true fill: true; 
		yourself.
	receivablePresenter := self newBoxLayoutTopToBottom
		add: 'Receivable' expand: false; 
		add: receivables  expand: true fill: true; 
		yourself.
	nonCash := self newBoxLayoutLeftToRight
		spacing: 5; 
		add: payablePresenter ;
		add: receivablePresenter ;
		yourself.
	^SpBoxLayout newTopToBottom 
	spacing: 5;
	add: balanceLayout height: 82"withConstraints: balanceConstraint" ;
	add: nonCash       expand: true fill: true;
	yourself.
]

{ #category : 'account ops' }
UserAccountPresenter >> deposit [
	|dialog windowPresenter|
	dialog := application newPresenter: DepositPresenter.
	windowPresenter := dialog openModal .
	windowPresenter isOk ifFalse: [ ^ self ].
	application deposit: (dialog depositAmount) to: userAccounts owner. 

]

{ #category : 'initialization' }
UserAccountPresenter >> initializePresenters [
	|right|
	right := [:ua | SpColumnAlignment right].
	
	cashOnHandBalanceText := self newLabel .
	cashAtBankBalanceText := self newLabel .
	
	accountBalances := self newTable .
	accountBalances 
		addColumn: (SpStringTableColumn new title: 'Account'; evaluated: #key; width: 100);
		addColumn: (SpStringTableColumn new title: 'Balnce';  evaluated: [:a | a value balance asStringWithCommas ]; width: 100; displayAlignment: right);
		addColumn: (SpStringTableColumn new title: ' '; evaluated: [:e | ' ']).
		
	accountBalances items: (userAccounts accountBalances).
	accountBalances enabled: false.
		
	payables := self newTable .
	payables 
		addColumn: (SpStringTableColumn title: 'To'     evaluated: #key);
		addColumn: (SpStringTableColumn title: 'Amount' evaluated: [:a | a value balance]).
	
	receivables := self newTable.
	receivables 
		addColumn: (SpStringTableColumn title: 'From'   evaluated: #key);
		addColumn: (SpStringTableColumn title: 'Amount' evaluated: [:a | a value balance]).

]

{ #category : 'initialization' }
UserAccountPresenter >> initializeWindow: aWindowPresenter [
	|depositButton transferButton toolbar|
"	aWindowPresenter whenClosedDo: [ 
		application class removePresenterToUpdateFor: application loggedInUser ]."
	depositButton := self newToolbarButton 
		label: 'Desposit';
		action: [ self deposit ];
		icon: (self iconNamed: #smallAdd);
		yourself.
	transferButton := self newToolbarButton 
		label: 'Transfer';
		action: [ self transfer ];
		icon: (self iconNamed: #glamorousRight ) ;
		yourself .
	toolbar := self newToolbar 
		add: depositButton ;
		add: transferButton;
		addStyle: 'toolbarButtonLabelStyle';
		yourself.
	aWindowPresenter 
		title: 'Accounts: ', userAccounts owner;
		toolbar: toolbar;
		initialExtent: 600@400 .

]

{ #category : 'accessing - model' }
UserAccountPresenter >> setModel: anUserAccounts [
	userAccounts := anUserAccounts 
]

{ #category : 'accessing - model' }
UserAccountPresenter >> setModelBeforeInitialization: anUserAccounts [
	userAccounts := anUserAccounts 
]

{ #category : 'account ops' }
UserAccountPresenter >> transfer [
	|dialog windowPresenter recipients|
	recipients := ((Ledger accountOwners) select: [:e | e ~= userAccounts owner ]) sort: [:a :b | a <= b ].
	dialog := application newPresenter: TransferPresenter.
	dialog recipients: recipients.
	windowPresenter := dialog openModal .
	windowPresenter isOk ifFalse: [ ^ self ].
	application transfer: (dialog amount) from: (userAccounts owner) to: (dialog recipient).

]

{ #category : 'initialization' }
UserAccountPresenter >> updatePresenter [ 
	super updatePresenter .
	"Transcript show: ('{1}.updatePresenter' format: {self class name }); cr."
	cashAtBankBalanceText label: ('{1}' format: {userAccounts cashAtBank balance}) .
	cashOnHandBalanceText label: ('{1}' format: {userAccounts cashOnHand balance}).
	accountBalances refresh .
"	payables       items: (userAccounts payables).
	receivables    items: (userAccounts receivables).
"	
]
