//
//  HMTargetActionList.m
//  HMRepeatableTapGestureRecognizer
//
//  Created by Muronaka Hiroaki on 2015/09/04.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

#import "HMTargetActionList.h"
#import "HMWeakTargetAction.h"

@interface HMTargetActionList()

@property(nonatomic, strong) NSMutableArray* targetActionList;

@end

@implementation HMTargetActionList

-(instancetype)init {
    
    self = [super init];
    if( self ) {
        self.targetActionList = [NSMutableArray new];
    }
    return self;
}

-(void)addTarget:(id)target action:(SEL)action {
    
    HMWeakTargetAction* item = [[HMWeakTargetAction alloc] initWithTarget:target action:action];
    
    if( [self findIndexOfTargetAction:item] == -1 ) {
        [self.targetActionList addObject:item];
    }
    
}

-(void)removeTaget:(id)target action:(SEL)action {
    HMWeakTargetAction* item = [[HMWeakTargetAction alloc] initWithTarget:target action:action];
    [self.targetActionList removeObject:item];
}

-(void)removeActionFromTarget:(id)target {
    
    NSInteger count = self.targetActionList.count -1 ;
    
    while( count >= 0 ) {
        HMWeakTargetAction* item = self.targetActionList[count];
        if( [item.target isEqual:target] ) {
            [self.targetActionList removeObjectAtIndex:count];
        }
        --count;
    }
    
}

-(void)removeAll {
    [self.targetActionList removeAllObjects];
}

-(void)fireWithObject:(id)sender {
    [self.targetActionList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        HMWeakTargetAction* item = obj;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [item.target performSelector:item.action withObject:sender];
#pragma clang diagonistic pop
    }];
}

-(NSInteger)findIndexOfTargetAction:(HMWeakTargetAction*)item {
    __block NSInteger result = -1;
    
    [self.targetActionList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if( [obj isEqual:item] ) {
            result = idx;
            *stop = YES;
        }
    }];
    
    return result;
}



@end
