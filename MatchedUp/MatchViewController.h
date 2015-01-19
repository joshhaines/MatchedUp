//
//  MatchViewController.h
//  MatchedUp
//
//  Created by Joshua Haines on 1/15/15.
//  Copyright (c) 2015 Joshua Haines. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MatchViewControllerDelegate <NSObject>

-(void)presentMatchesViewController;

@end

@interface MatchViewController : UIViewController

@property (strong, nonatomic) UIImage *matchedUserImage;
@property (weak) id <MatchViewControllerDelegate> delegate;

@end
