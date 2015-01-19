//
//  TransitionAnimator.h
//  MatchedUp
//
//  Created by Joshua Haines on 1/17/15.
//  Copyright (c) 2015 Joshua Haines. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL presenting;

@end
