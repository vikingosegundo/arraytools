//
//  NSArray+RandomUtils.h
//  ClickwheelOrderDemo
//
//  Created by Manuel Meyer on 06.10.11.
//  Copyright (c) 2011 apparatschik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (RandomUtils)
-(NSMutableArray *)mutableArrayShuffled;
-(NSMutableArray *)arrayShuffled;
-(id)randomElement;
-(NSSet *)setWithRandomElementsSize:(NSUInteger)size;
-(NSArray *)arrayWithRandomElementsSize:(NSUInteger)size;

@end

@interface NSMutableArray (RandomUtils) 
-(void)shuffle;
@end
