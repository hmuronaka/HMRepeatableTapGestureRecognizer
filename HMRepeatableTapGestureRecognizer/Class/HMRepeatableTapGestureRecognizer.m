//
//  HMRepeatableTapGestureRecognizer.m
//  HMRepeatableTapGestureRecognizer
//
//  Created by Muronaka Hiroaki on 2015/09/03.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

#import <UIKit/UIGestureRecognizerSubclass.h>
#import "HMRepeatableTapGestureRecognizer.h"
#import "HMTargetActionList.h"

@interface HMRepeatableTapGestureRecognizer()

@property(nonatomic, strong) NSTimer* longPressTimer;
@property(nonatomic, strong) NSTimer* repeatActionTimer;
@property(nonatomic, strong) HMTargetActionList* targetActionList;

@end

@implementation HMRepeatableTapGestureRecognizer

-(instancetype)initWithTarget:(id)target action:(SEL)action {
    
    self = [super initWithTarget:self action:@selector(handleFromSuper:)];
    
    if( self ) {
        self.targetActionList = [HMTargetActionList new];
        [self.targetActionList addTarget:target action:action];
    }
    
    return self;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark action

-(void)handleFromSuper:(UIGestureRecognizer*)gesture {
    switch(gesture.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateCancelled:
            [self.targetActionList fireWithObject:self];
            break;
        case UIGestureRecognizerStateChanged:
            break;
        default:
            break;
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark override methods

-(void)addTarget:(id)target action:(SEL)action {
    [self.targetActionList addTarget:target action:action];
}

-(void)removeTarget:(id)target action:(SEL)action {
    [self.targetActionList removeTaget:target action:action];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self cancelTimers];
    
    [super touchesBegan:touches withEvent:event];
    self.state = UIGestureRecognizerStateBegan;
    self.longPressTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startRepeatAction:) userInfo:nil repeats:NO];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self cancelTimers];
    [super touchesEnded:touches withEvent:event];
    self.state = UIGestureRecognizerStateEnded;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self cancelTimers];
}

-(void)reset {
    [super reset];
    [self cancelTimers];
}

/////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark timer

-(void)startRepeatAction:(NSTimer*)timer {
    
    self.repeatActionTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(repeatAction:) userInfo:nil repeats:YES];
}

-(void)repeatAction:(NSTimer*)timer {
    self.state = UIGestureRecognizerStateChanged;
    [self.targetActionList fireWithObject:self];
}

-(void)cancelTimers {
    if( [self.longPressTimer isValid] ) {
        [self.longPressTimer invalidate];
    }
    self.longPressTimer = nil;
    
    if( [self.repeatActionTimer isValid] ) {
        [self.repeatActionTimer invalidate];
    }
    self.repeatActionTimer = nil;
}

@end
