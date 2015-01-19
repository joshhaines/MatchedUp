//
//  ChatViewController.h
//  MatchedUp
//
//  Created by Joshua Haines on 1/15/15.
//  Copyright (c) 2015 Joshua Haines. All rights reserved.
//

#import "JSMessagesViewController.h"

@interface ChatViewController : JSMessagesViewController <JSMessagesViewDataSource, JSMessagesViewDelegate>

@property (strong, nonatomic) PFObject *chatRoom;

@end
