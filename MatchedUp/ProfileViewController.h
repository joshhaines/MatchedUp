//
//  ProfileViewController.h
//  MatchedUp
//
//  Created by Joshua Haines on 1/12/15.
//  Copyright (c) 2015 Joshua Haines. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileViewControllerDelegate <NSObject>

-(void)didPressLike;
-(void)didPressDislike;

@end

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) PFObject *photo;
@property (weak) id <ProfileViewControllerDelegate> delegate;

@end
