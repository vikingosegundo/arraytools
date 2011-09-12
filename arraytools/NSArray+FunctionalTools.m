//
//  NSArray+FuntionalTools.m
//  arraytools
//
//  Created by vikingosegundo on 28.08.11.
//  Copyright (c) 2011 vikingosegundo. All rights reserved.
//

#import "NSArray+FunctionalTools.h"

@implementation NSArray (FunctionalTools)
-(NSArray *)filter:(BOOL (^)(id))filterBlock
{
	NSMutableArray *filteredArray = [NSMutableArray array]; 
	for (id element in self) 
		if (filterBlock(element))	
			[filteredArray addObject:element]; 
	return [NSArray arrayWithArray:filteredArray]; 
}

+(NSArray *)arrayByPerformingBlock:(id (^)(NSInteger))performBlock withIndexFromRange:(NSRange)range
{
	NSMutableArray *array = [NSMutableArray array];
	for (NSUInteger i = range.location; i< range.location+range.length; ++i) {
		[array addObject:performBlock(i)];
	}
	return array;
}
- (NSArray *)arrayByPerformingBlock:(id  (^)(id element))performBlock 
{
	return [self arrayByPerformingBlock:performBlock
					ifElementPassesTest:^BOOL(id element) { return  YES;}];
}

- (NSArray *)arrayByPerformingBlock:(id(^)(id element))performBlock 
					   ifElementPassesTest:(BOOL(^)(id element))testBlock
{

	return [self arrayByPerformingBlock:performBlock 
						   ifElementPassesTest:testBlock 
					   elsePerformBlock:^(id element){;}];
}

-(NSArray *)arrayByPerformingBlock:(id (^)(id))performBlock 
					  ifElementPassesTest:(BOOL (^)(id))testBlock 
				  elsePerformBlock:(void (^)(id))elseBlock
{
	NSMutableArray *array = [NSMutableArray array];
	for (id element in self)
		if(testBlock(element))
			[array addObject:performBlock(element)];
		else
			elseBlock(element);
	return array;
}


- (NSArray *)arrayByPerformingBlock:(id   (^)(id element))performBlock 
				ifElementPassesTest:(BOOL (^)(id element))testBlock
				   elsePerformBlock:(void (^)(id element))elseBlock
						   succeded:(void (^)())succesBlock
							 failed:(void (^)(id element))failedBlock
				   stopOnFailedTest:(BOOL)stop

{
	NSMutableArray *array = [NSMutableArray array];
	for (id element in self){
		if(testBlock(element))
			[array addObject:performBlock(element)];
		else{
			elseBlock(element);
			if (stop) {
				failedBlock(element);
				break;
			}
		}
	}
	
	if (!stop) {
		succesBlock();
	}
	
	
	return array;

}

-(void)performBlock:(void (^)(id))block
{
	for(id element in self) {
		block(element);
	}
}

@end
