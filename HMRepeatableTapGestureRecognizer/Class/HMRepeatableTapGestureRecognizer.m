//
//  HMRepeatableTapGestureRecognizer.m
//  HMRepeatableTapGestureRecognizer
//
//  Created by Muronaka Hiroaki on 2015/09/03.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

#import <UIKit/UIGestureRecognizerSubclass.h>
#import "HMRepeatableTapGestureRecognizer.h"
#import <HMTargetActionListFramework/HMTargetActionListFramework.h>

@interface HMRepeatableTapGestureRecognizer()

@property(nonatomic, strong) NSTimer* longPressTimer;
@property(nonatomic, strong) NSTimer* repeatActionTimer;
@property(nonatomic, strong) HMTargetActionList* targetActionList;
@property(nonatomic, assign) NSInteger currentTouchesCount;

@end

@implementation HMRepeatableTapGestureRecognizer

-(instancetype)initWithTarget:(id)target action:(SEL)action {
    
    self = [super initWithTarget:self action:@selector(handleFromSuper:)];
    
    if( self ) {
        self.targetActionList = [HMTargetActionList new];
        [self.targetActionList addTarget:target action:action];
        
        _minimumPressDuration = 0.5;
        _repeatInterval = 0.2;
        _numberOfTouchesRequired = 1;
        _currentTouchesCount = 0;
    }
    
    return self;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark action

-(void)handleFromSuper:(UIGestureRecognizer*)gesture {
    switch(gesture.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateCancelled:
            [self.targetActionList fireWithSender:self];
            break;
        case UIGestureRecognizerStateEnded:
            if( self.currentTouchesCount == self.numberOfTouchesRequired ) {
//                [self.targetActionList fireWithSender:self];
            }
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
    self.currentTouchesCount += touches.count;
    
    if( self.currentTouchesCount < self.numberOfTouchesRequired ) {
        return;
    } else if( self.currentTouchesCount > self.numberOfTouchesRequired ) {
        if ( self.state == UIGestureRecognizerStatePossible ) {
            self.state = UIGestureRecognizerStateFailed;
        } else {
            self.state = UIGestureRecognizerStateCancelled;
        }
        return;
    }
    
    [super touchesBegan:touches withEvent:event];
    self.state = UIGestureRecognizerStateBegan;
    
    if( self.minimumPressDuration > 0.0 ) {
        self.longPressTimer = [NSTimer scheduledTimerWithTimeInterval:self.minimumPressDuration target:self selector:@selector(startRepeatAction:) userInfo:nil repeats:NO];
    } else {
        [self startRepeatAction:nil];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.state = UIGestureRecognizerStateEnded;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
}

-(void)reset {
    self.currentTouchesCount = 0;
    [self cancelTimers];
    [super reset];
    
}

/////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark timer

-(void)startRepeatAction:(NSTimer*)timer {
    if( self.repeatInterval > 0.0 ) {
        self.repeatActionTimer = [NSTimer scheduledTimerWithTimeInterval:self.repeatInterval target:self selector:@selector(repeatAction:) userInfo:nil repeats:YES];
    }
}

-(void)repeatAction:(NSTimer*)timer {
    self.state = UIGestureRecognizerStateChanged;
    [self.targetActionList fireWithSender:self];
}

-(void)cancelTimers {
    [self.longPressTimer invalidate];
    self.longPressTimer = nil;
    
    [self.repeatActionTimer invalidate];
    self.repeatActionTimer = nil;
}

@end
