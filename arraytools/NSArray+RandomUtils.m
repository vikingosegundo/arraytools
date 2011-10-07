//
//  NSArray+RandomUtils.m
//  ClickwheelOrderDemo
//
//  Created by Manuel Meyer on 06.10.11.
//  Copyright (c) 2011 apparatschik. All rights reserved.
//

#import "NSArray+RandomUtils.h"

@implementation NSArray (RandomUtils)

-(NSMutableSet *)mutableSet
{
	return [NSMutableSet setWithArray:self];
}

-(NSMutableArray *)mutableArrayShuffledWithoutDuplicates
{
	NSMutableArray *array = [[[self mutableSet] allObjects] mutableCopy];
	[array shuffle];
	return [array autorelease];
}

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
	
	NSMutableArray *array = [self mutableArrayShuffledWithoutDuplicates];
	if (size > [array count]) 
		[NSException raise:NSInternalInconsistencyException 
					format:@"NSArray's size (%d) is too small to fill a set with size %d", [array count], size];	
	return [NSSet setWithArray:[array subarrayWithRange:NSMakeRange(0, size)]];
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
