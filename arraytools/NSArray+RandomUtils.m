//
//  NSArray+RandomUtils.m
//  ClickwheelOrderDemo
//
//  Created by Manuel Meyer on 06.10.11.
//  Copyright (c) 2011 apparatschik. All rights reserved.
//

#import "NSArray+RandomUtils.h"

@implementation NSArray (RandomUtils)

-(NSMutableArray *)mutableArrayShuffled
{
	NSMutableArray *array = [[self mutableCopy] autorelease];
	[array shuffle];
	return array;
}

-(NSMutableArray *)arrayShuffled
{
	return [NSArray arrayWithArray:[self mutableArrayShuffled]];
}

-(id)randomElement
{
	if ([self count] < 1) return nil;
	NSUInteger randomIndex = arc4random() % [self count];
	return [self objectAtIndex:randomIndex];
}

-(NSSet *)setWithRandomElementsSize:(NSUInteger)size
{
	if ([self count]<1) return nil;
	if (size > [self count]) 
		[NSException raise:@"NSArrayNotEnoughElements" 
					format:@"NSArray's size (%d) is too small to fill a random set with size %d", [self count], size];

	NSMutableSet *set = [NSMutableSet set];
	NSMutableArray *array = [self mutableArrayShuffled];
	
	if (size == [array count]) 
		return [NSSet setWithArray:array];
	
	while ([set count]< size) {
		id object = [array objectAtIndex:0];
		[array removeObjectAtIndex:0];
		[set addObject:object];
		
	}
	return [NSSet setWithSet:set];
}

-(NSArray *)arrayWithRandomElementsSize:(NSUInteger)size
{
	if ([self count]<1) return nil;
	
	NSMutableArray *array = [NSMutableArray array];
	while ([array count] < size) {
		[array addObject:[self randomElement]];
	}
	return  [NSArray arrayWithArray:array];
}
@end

@implementation NSMutableArray (RandomUtils)
-(void)shuffle
{

	NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSUInteger nElements = count - i;
        NSUInteger n = (arc4random() % nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end
