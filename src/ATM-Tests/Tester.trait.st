"
common for all *UT classes
"
Trait {
	#name : 'Tester',
	#instVars : [
		'tester'
	],
	#category : 'ATM-Tests',
	#package : 'ATM-Tests'
}

{ #category : 'accessing' }
Tester >> tester [

	^ tester
]

{ #category : 'accessing' }
Tester >> tester: aTester [

	tester := aTester
]
