"
common for all *UT classes
"
Trait {
	#name : 'Tester',
	#instVars : [
		'tester'
	],
	#category : 'ATM-Tests-base',
	#package : 'ATM-Tests',
	#tag : 'base'
}

{ #category : 'accessing' }
Tester >> tester [

	^ tester
]

{ #category : 'accessing' }
Tester >> tester: aTester [

	tester := aTester
]
