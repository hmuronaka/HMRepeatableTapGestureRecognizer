//
//  HMTargetActionList.h
//  HMRepeatableTapGestureRecognizer
//
//  Created by Muronaka Hiroaki on 2015/09/04.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTargetActionList : NSObject

-(instancetype)init;

-(void)addTarget:(id)target action:(SEL)action;
-(void)removeActionFromTarget:(id)target;
-(void)removeTaget:(id)target action:(SEL)action;
-(void)removeAll;

-(void)fireWithObject:(id)obj;

@end
