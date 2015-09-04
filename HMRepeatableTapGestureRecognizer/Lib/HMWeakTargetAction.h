//
//  HMWeakTargetAction.h
//  HMRepeatableTapGestureRecognizer
//
//  Created by Muronaka Hiroaki on 2015/09/04.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMWeakTargetAction : NSObject

@property(nonatomic, weak) NSObject* target;
@property(nonatomic, assign) SEL action;

-(instancetype)initWithTarget:(NSObject*)target action:(SEL)action;
-(BOOL)isEqual:(id)object;

@end
