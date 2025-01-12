"
comment
"
Class {
	#name : 'AtmFormPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'balanceText',
		'journalEntries',
		'payable',
		'receivable'
	],
	#category : 'ATM',
	#package : 'ATM'
}

{ #category : 'account ops' }
AtmFormPresenter >> balance [
	^application balance
]

{ #category : 'layout' }
AtmFormPresenter >> defaultLayout [ 
	|payablePresenter receivablePresenter  balanceLayout nonCash balLabel|
	balLabel := self newLabel label: 'balance: '"; addStyle: 'balanceLabel'"; yourself.
	balanceLayout := self newBoxLayoutLeftToRight
		add: balLabel expand: false; add: balanceText expand: true fill: true;
		yourself .
	payablePresenter := self newBoxLayoutTopToBottom
		add: 'Payable' expand: false; 
		add: payable expand: true fill: true; 
		yourself.
	receivablePresenter := self newBoxLayoutTopToBottom
		add: 'Receivable' expand: false; 
		add: receivable expand: true fill: true; 
		yourself.
	nonCash := self newBoxLayoutLeftToRight
		spacing: 5; 
		add: payablePresenter ;
		add: receivablePresenter ;
		yourself.
	^SpBoxLayout newTopToBottom 
	spacing: 5;
	add: (application loggedInUser ) expand: false fill: false; 
	add: balanceLayout expand: false fill: false;
	add: nonCash expand: true fill: true;
	"add: (SpBoxLayout new) height: 5;"
	add: 'Journal' expand: false fill: false;
	add: journalEntries expand: true fill: true;
	yourself.
]

{ #category : 'account ops' }
AtmFormPresenter >> deposit [
	|dialog windowPresenter|
	dialog := application newPresenter: DepositPresenter.
	windowPresenter := dialog openModal .
	windowPresenter isOk ifFalse: [ ^ self ].
	application deposit: (dialog depositAmount). 

]

{ #category : 'initialization' }
AtmFormPresenter >> initializePresenters [
	|idColumn dateColumn timeColumn accountColumn dcColumn amountColumn accountName posted| 
	balanceText := self newLabel .
	journalEntries := self newTable 
		propagateNaturalWidth: true ;
		propagateNaturalHeight: true .
	idColumn := SpStringTableColumn new 
		title: 'Id';
		evaluated: #id;
		displayAlignment: [:je | SpColumnAlignment right];
		yourself.
	accountName := SpStringTableColumn title: 'Name' evaluated: [ :je | je name ].
	dateColumn := SpStringTableColumn new 
		title: 'Date';
		evaluated: #date;
		displayAlignment: [:je | SpColumnAlignment right];
		yourself.
	timeColumn := SpStringTableColumn title: 'Time' evaluated: #time.
	accountColumn := SpStringTableColumn title: 'Account' evaluated: #accountType .
	dcColumn := SpStringTableColumn title: 'Operation' evaluated: #transactionType .
	amountColumn := SpStringTableColumn new 
		title: 'Amount'; 
		evaluated: #amount;
		displayAlignment: [:je | SpColumnAlignment right];
		"width: 80;"
		yourself.
	posted := SpStringTableColumn new 
		title: 'Posted'; 
		evaluated: #posted;
		displayAlignment: [:je | SpColumnAlignment center ].
	journalEntries 
		addColumn: idColumn ;
		addColumn: dateColumn ;
		addColumn: timeColumn ;
		addColumn: accountName ;
		addColumn: accountColumn ;
		addColumn: dcColumn ;
		addColumn: amountColumn ;
		addColumn: posted.
		
	payable := self newTable .
	payable 
		addColumn: (SpStringTableColumn title: 'To' evaluated: #key);
		addColumn: (SpStringTableColumn title: 'Amount' evaluated: [:a | a value balance]).
	
	receivable := self newTable.
	receivable 
		addColumn: (SpStringTableColumn title: 'From' evaluated: #key);
		addColumn: (SpStringTableColumn title: 'Amount' evaluated: [:a | a value balance]).

]

{ #category : 'initialization' }
AtmFormPresenter >> initializeWindow: aWindowPresenter [
	|depositButton transferButton postButton toolbar|
	aWindowPresenter whenClosedDo: [ 
		application class removePresenterToUpdateFor: application loggedInUser ].
	postButton := self newToolbarButton 
		label: 'Post';
		action: [ self post ];
		icon: (self iconNamed: #scriptManager ) ;
		yourself.
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
		add: postButton ;
		addStyle: 'toolbarButtonLabelStyle';
		yourself.
	aWindowPresenter 
		title: 'ATM';
		toolbar: toolbar;
		initialExtent: 600@800 .

]

{ #category : 'operations' }
AtmFormPresenter >> post [ 
	application post.
]

{ #category : 'account ops' }
AtmFormPresenter >> transfer [
	|dialog windowPresenter|
	dialog := application newPresenter: TransferPresenter.
	windowPresenter := dialog openModal .
	windowPresenter isOk ifFalse: [ ^ self ].
	application transfer: (dialog amount) to: (dialog recipient).

]

{ #category : 'initialization' }
AtmFormPresenter >> updatePresenter [ 
	super updatePresenter .
	Transcript show: ('{1}.updatePresenter for {2}' format: {self class name . application loggedInUser }); cr.
	balanceText label: ('{1}' format: {self balance}) .
	payable items: (Accounts payableFor: (application loggedInUser )).
	receivable items: (Accounts receivableFor: (application loggedInUser )).
	journalEntries items: (Journal entriesFor: application loggedInUser)
	
]
