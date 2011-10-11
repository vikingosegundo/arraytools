#arraytools

This is a set of methods to ease the handling of NSArray.  
So far it includes methods using blocks to enable functional-style programming

	array = [array arrayByPerformingBlock:^id  (id element) {return [NSNumber numberWithLong:[(NSNumber *)element longValue] * 3];} 
							  ifElementPassesTest:^BOOL(id element) {return [element longValue] %2 ==0 ;}];
							
or 

    NSMutableArray *falsePositives = [NSMutableArray array];
	array = [NSArray arrayWithObjects:@"aa", @"ab",@"c",@"ad",@"dd", nil];

	array = [array arrayByPerformingBlock:^id  (id element) {return [element stringByAppendingString:element];} 
						  ifElementPassesTest:^BOOL(id element) {return [element hasPrefix:@"a"];}
							 elsePerformBlock:^    (id element) {[falsePositives addObject:element];}
				 ]; 
				
and a toolset for handling shuffling

    NSSet *set = [array setWithRandomElementsSize:3];
	NSArray *shuffeldArray = [array arrayShuffled];


A compact Quicksort imlementation:

	NSArray* quicksort(NSArray *array)
	{
		if ([array count]<2) return array;
		
		id pivot = [array randomElement];
		NSMutableArray *array2= [NSMutableArray array];
		
		array = [array arrayByPerformingBlock:^id(id element) { return element;} 
						  ifElementPassesTest:^BOOL(id element) {return [element intValue] < [pivot intValue];} 
							 elsePerformBlock:^(id element) { if (element!=pivot) [array2 addObject:element];}
		];
		return [[[NSArray arrayWithArray:quicksort(array)] arrayByAddingObject:pivot] arrayByAddingObjectsFromArray:quicksort(array2)];
	}