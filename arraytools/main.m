//
//  main.m
//  arraytools
//
//  Created by vikingosegundo on 28.08.11.
//  Copyright (c) 2011 vikingosegundo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+FunctionalTools.h"
#import "NSArray+RandomUtils.h"

int main (int argc, const char * argv[])
{

	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
		NSArray *array = [NSArray arrayWithObjects:@"aa", @"ab",@"c",@"ad",@"dd", nil];
		
		array = [array arrayByPerformingBlock:^id(id element) { return [element stringByAppendingString:element]; } 
						  ifElementPassesTest:^BOOL(id element) {return [element hasPrefix:@"a"];}];
		NSLog(@"%@", array);
		
		NSMutableArray *falsePositives = [NSMutableArray array];
		array = [NSArray arrayWithObjects:@"aa", @"ab",@"c",@"ad",@"dd", nil];
		
		array = [array arrayByPerformingBlock:^id  (id element) {return [element stringByAppendingString:element];} 
						  ifElementPassesTest:^BOOL(id element) {return [element hasPrefix:@"a"];}
							 elsePerformBlock:^    (id element) {[falsePositives addObject:element];}
				 ];
		NSLog(@"%@\n%@", array, falsePositives);
		array = [NSArray arrayByPerformingBlock:^id(NSInteger index) {return [NSNumber numberWithLong:index*index*index];} 
							 withIndexFromRange:NSMakeRange(0, 10)];
		
		array = [array arrayByPerformingBlock:^id  (id element) {return [NSNumber numberWithLong:[(NSNumber *)element longValue] * 3];} 
						  ifElementPassesTest:^BOOL(id element) {return [element longValue] %2 ==0 ;}];
		NSLog(@"%@", array);
		
		array = [NSArray arrayWithObjects:@"aa", @"ab",@"c",@"ad",@"dd", nil];
		
		NSMutableArray *positive = [NSMutableArray array];
		NSMutableArray *negative = [NSMutableArray array];
		[array performBlock:^(id element) {if ([element hasPrefix:@"a"]) [positive addObject:element]; else [negative addObject:element];}];
		NSLog(@"%@", positive);
		NSLog(@"%@", negative);
		
		
		NSArray *youtubeVideos = [[NSArray arrayWithObjects: 
								  @"http://example.com/index.php?number=1&keyword=", 
								  @"http://example.com/index.php?number=2&keyword=",
								   nil] arrayByPerformingBlock:^id(id element) { return [element stringByAppendingString:@"KeyWord"];}];
		
		NSLog(@"%@", youtubeVideos);
	
	NSArray *myArray =[NSArray arrayWithObjects: [NSNumber numberWithFloat:45.0],[NSNumber numberWithFloat:122.0], [NSNumber numberWithFloat:21.01], [NSNumber numberWithFloat:5.9], nil];
//	NSArray *sortedArray = [myArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//		if ([obj1 floatValue] > [obj2 floatValue])
//			return NSOrderedDescending;
//		else if ([obj1 floatValue] < [obj2 floatValue])
//			return NSOrderedAscending;
//		return NSOrderedSame;
//	}];
//	
//	NSLog(@"%@", sortedArray);
	
	
	NSSortDescriptor *sortDescriptor;
	sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"floatValue"
												  ascending:YES] autorelease];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	NSArray *sortedArray = [myArray sortedArrayUsingDescriptors:sortDescriptors];
	NSLog(@"%@", sortedArray);
	
	array = [NSArray arrayWithObjects:@"aa", @"ab",@"c",@"ad",@"dd", nil];
	array = [array arrayByAddingObjectsFromArray:array];
	NSSet *set = [array setWithRandomElementsSize:2];
	NSLog(@"%@ %lu", set, [set count]);
	
	NSArray *shuffeldArray = [array arrayWithRandomElementsSize:9];
	NSLog(@"%@ %lu", shuffeldArray, [shuffeldArray count]);
	
	id object = [array randomElement];
	NSLog(@"%@", object);
	
	[pool drain];
    return 0;
}

