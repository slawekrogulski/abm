"
Main presenter
"
Class {
	#name : 'AtmApplicationPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'users',
		'addUserButton',
		'openUserAccountsButton',
		'deleteUserButton',
		'openJournalButton'
	],
	#category : 'ATM-ui',
	#package : 'ATM',
	#tag : 'ui'
}

{ #category : 'actions' }
AtmApplicationPresenter >> addUser [
	|dialog windowPresenter|
	dialog := application newPresenter: UserAddPresenter.
	windowPresenter := dialog openModal .
	windowPresenter isOk ifFalse: [ ^ self ].
	Ledger add: (UserAccounts newFor: (dialog newUserName )). 
	self initializeUsers .
	self updatePresenter .
]

{ #category : 'running' }
AtmApplicationPresenter >> debug [
	application windows inspect
]

{ #category : 'layout' }
AtmApplicationPresenter >> defaultLayout [ 
^SpBoxLayout newTopToBottom 
	spacing: 5;
	"borderWidth: 5;"
	add: users expand: true fill: true;
	yourself.
]

{ #category : 'actions' }
AtmApplicationPresenter >> deleteUser [
	|dialog windowPresenter|
	dialog := application newPresenter: UserDeletePresenter .
	windowPresenter := dialog openModal .
	windowPresenter isOk ifFalse: [ ^ self ].
	Ledger remove: users selectedItem owner . 
	self initializeUsers .
	self updatePresenter .
]

{ #category : 'initialization' }
AtmApplicationPresenter >> initializePresenters [
	|right center|
	right := [:ua | SpColumnAlignment right].
	center := [:ua | SpColumnAlignment center ].
	users := self newTable
		propagateNaturalWidth: true ;
		propagateNaturalHeight: true .
	{
	SpStringTableColumn new title: 'Name'      ; evaluated: #owner.
	SpStringTableColumn new title: 'Balance'   ; evaluated: [:ue | ue balance asStringWithCommas ]; displayAlignment: right; width: 100.
	SpStringTableColumn new title: ' '         ; evaluated: [ :ua | '' ]; width: 5
	} do: [ :column | users addColumn: column ].
	users activateOnDoubleClick .
	users whenActivatedDo: [ :selection | self openUserAccounts: (selection selectedItem)]
	

]

{ #category : 'as yet unclassified' }
AtmApplicationPresenter >> initializeUsers [
	users items: (Ledger list sort: [:a :b | a owner <= b owner]).
]

{ #category : 'initialization' }
AtmApplicationPresenter >> initializeWindow: aWindowPresenter [
	| toolbar|
"	aWindowPresenter whenClosedDo: [ 
		application class removePresenterToUpdateFor: application loggedInUser ]."
	aWindowPresenter whenOpenedDo: [ self whenPresenterOpenedDo ].

	addUserButton := self newToolbarButton 
		label: 'Add';
		action: [ self addUser ];
		icon: (self iconNamed: #add ) ;
		yourself.
	openUserAccountsButton := self newToolbarButton 
		label: 'Open';
		action: [ self openUserAccounts ];
		icon: (self iconNamed: #open );
		disable;
		yourself.
	deleteUserButton := self newToolbarButton 
		label: 'Delete';
		action: [ self deleteUser ];
		icon: (self iconNamed: #delete);
		yourself.
	openJournalButton := self newToolbarButton 
		label: 'Journal';
		action: [ self openJournal ];
		icon: (self iconNamed: #book);
		yourself.
	users whenNoneSelectedDo: [ self userActionButtonsDisable ].
	users whenSelectedDo: [ :selectedItem | self userActionButtonsEnable ].
	toolbar := self newToolbar 
		add: addUserButton ;
		add: openUserAccountsButton ;
		add: deleteUserButton ;
		add: openJournalButton ;
		add: (self newToolbarButton label: 'Clear'; action: [users unselectAll]);
		add: (self newToolbarButton label: 'Debug'; action: [self debug]);
		addStyle: 'toolbarButtonLabelStyle';
		yourself.
	aWindowPresenter 
		title: 'ATM';
		toolbar: toolbar;
		initialExtent: 400@300 .

]

{ #category : 'opening' }
AtmApplicationPresenter >> openJournal [
	application openJournal: self
]

{ #category : 'actions' }
AtmApplicationPresenter >> openUserAccounts [
	self openUserAccounts: users selectedItem
]

{ #category : 'actions' }
AtmApplicationPresenter >> openUserAccounts: userAccount [
	application openUserAccounts: userAccount owner: self
]

{ #category : 'initialization' }
AtmApplicationPresenter >> updatePresenter [ 
	super updatePresenter .
	"Transcript show: ('{1}.updatePresenter for {2}' format: {self class name . application loggedInUser }); cr."
	users refresh.
]

{ #category : 'as yet unclassified' }
AtmApplicationPresenter >> userActionButtonsDisable [ 
	openUserAccountsButton disable.
	deleteUserButton disable.
]

{ #category : 'as yet unclassified' }
AtmApplicationPresenter >> userActionButtonsEnable [
	openUserAccountsButton enable.
	deleteUserButton enable.
]

{ #category : 'as yet unclassified' }
AtmApplicationPresenter >> whenPresenterOpenedDo [ 
	self userActionButtonsDisable .
	self initializeUsers 
]
