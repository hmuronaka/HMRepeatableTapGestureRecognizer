//
//  ViewController.m
//  HMRepeatableTapGestureRecognizer
//
//  Created by Muronaka Hiroaki on 2015/09/03.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

#import "ViewController.h"
#import "HMRepeatableTapGestureRecognizer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    view.backgroundColor = [UIColor greenColor];
    view.userInteractionEnabled = YES;
    
    [self.view addSubview:view];
    
    HMRepeatableTapGestureRecognizer* gesture = [[HMRepeatableTapGestureRecognizer alloc] initWithTarget:self  action:@selector(tappedView:)];
//    gesture.minimumPressDuration = 0.5;
//    gesture.repeatDuration = 0.2;
//    gesture.numberOfTouchesRequired
    [view addGestureRecognizer:gesture];
}

-(void)tappedView:(HMRepeatableTapGestureRecognizer*)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateChanged:
            NSLog(@"CHANGED");
            break;
        case UIGestureRecognizerStateBegan:
            NSLog(@"BEGAN");
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"ENDED");
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"FAILED");
            break;
        case UIGestureRecognizerStatePossible:
            NSLog(@"POSSIBLE");
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"CANCELED");
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
