//
//  HMWeakTargetAction.m
//  HMRepeatableTapGestureRecognizer
//
//  Created by Muronaka Hiroaki on 2015/09/04.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

#import "HMWeakTargetAction.h"

@implementation HMWeakTargetAction

-(instancetype)initWithTarget:(NSObject*)target action:(SEL)action {
    
    self = [super init];
    
    if( self ) {
        self.target = target;
        self.action = action;
    }
    
    return self;
}

-(BOOL)isEqual:(id)object {
    HMWeakTargetAction* other = object;
    
    return (self == other) ||
    ([self.target isEqual:other.target] && self.action == other.action);
    
}

@end
