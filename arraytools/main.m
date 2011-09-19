//
//  main.m
//  arraytools
//
//  Created by vikingosegundo on 28.08.11.
//  Copyright (c) 2011 vikingosegundo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+FunctionalTools.h"
int main (int argc, const char * argv[])
{

	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
		NSArray *array = [NSArray arrayWithObjects:@"aa", @"ab",@"c",@"ad",@"dd", nil];
		
		array = [array arrayByPerformingBlock:^id(id element) { return [element stringByAppendingString:element]; } 
						  ifElementPassesTest:^BOOL(id element) {return [element hasPrefix:@"a"];}
				 ];
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
						  ifElementPassesTest:^BOOL(id element) {return [element longValue] %2 ==0 ;}
				 ];
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
	[pool drain];
    return 0;
}

