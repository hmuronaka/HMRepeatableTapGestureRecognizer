//
//  HMRepeatableTapGestureRecognizer.h
//  HMRepeatableTapGestureRecognizer
//
//  Created by Muronaka Hiroaki on 2015/09/03.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMRepeatableTapGestureRecognizer : UIGestureRecognizer

@property(nonatomic, assign) NSTimeInterval minimumPressDuration;
@property(nonatomic, assign) NSTimeInterval repeatInterval;
@property(nonatomic, assign) NSInteger numberOfTouchesRequired;

-(instancetype)initWithTarget:(id)target action:(SEL)action;

@end
