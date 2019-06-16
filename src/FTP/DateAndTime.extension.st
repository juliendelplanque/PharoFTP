Extension { #name : #DateAndTime }

{ #category : #'*ftp-converting' }
DateAndTime >> asFtpTimeStamp [
	^ String streamContents: [ :stream |
		self dayMonthYearDo: [ :day :month :year |
			stream nextPutAll: (year asString padLeftTo: 4 with: $0).
			stream nextPutAll: (month asString padLeftTo: 2 with: $0).
			stream nextPutAll: (day asString padLeftTo: 2 with: $0) ].
		stream nextPutAll: (self hours asString padLeftTo: 2 with: $0).
		stream nextPutAll: (self minutes asString padLeftTo: 2 with: $0).
		stream nextPutAll: (self seconds asString padLeftTo: 2 with: $0).
		self nanoSecond isZero ifFalse: [ 
			stream nextPut: $.; nextPutAll: (self nanoSecond asString padLeftTo: 3 with: $0) ] ].
]
