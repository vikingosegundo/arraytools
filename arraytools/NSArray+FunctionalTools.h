//
//  NSArray+FuntionalTools.h
//  arraytools
//
//  Created by Manuel Meyer on 28.08.11.
//  Copyright (c) 2011 apparatschik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FunctionalTools)
- (NSArray*)filter:(BOOL(^)(id element))filterBlock;

+(NSArray *)arrayByPerformingBlock:(id(^)(NSInteger index))performBlock 
				withIndexFromRange:(NSRange)range;

- (NSArray *)arrayByPerformingBlock:(id  (^)(id element))performBlock;

- (NSArray *)arrayByPerformingBlock:(id  (^)(id element))performBlock 
				ifElementPassesTest:(BOOL(^)(id element))testBlock;

- (NSArray *)arrayByPerformingBlock:(id   (^)(id element))performBlock 
				ifElementPassesTest:(BOOL (^)(id element))testBlock
				   elsePerformBlock:(void (^)(id element))elseBlock; 

- (NSArray *)arrayByPerformingBlock:(id   (^)(id element))performBlock 
				ifElementPassesTest:(BOOL (^)(id element))testBlock
				   elsePerformBlock:(void (^)(id element))elseBlock
						   succeded:(void (^) ())succesBlock
							 failed:(void (^)(id element))failedBlock
				   stopOnFailedTest:(BOOL)stop;


-(void)performBlock:(void (^) (id element))block;
@end
