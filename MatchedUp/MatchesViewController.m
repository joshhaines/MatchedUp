//
//  MatchesViewController.m
//  MatchedUp
//
//  Created by Joshua Haines on 1/15/15.
//  Copyright (c) 2015 Joshua Haines. All rights reserved.
//

#import "MatchesViewController.h"
#import "ChatViewController.h"

@interface MatchesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *availableChatRooms;

@end

@implementation MatchesViewController

#pragma mark - lazy instantiation

-(NSMutableArray *)availableChatRooms
{
    if (!_availableChatRooms) {
        _availableChatRooms = [[NSMutableArray alloc] init];
    }
    return _availableChatRooms;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self updateAvailableChatRooms];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ChatViewController *chatVC = segue.destinationViewController;
    NSIndexPath *indexPath = sender;
    chatVC.chatRoom = [self.availableChatRooms objectAtIndex:indexPath.row];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Helper Methods

-(void)updateAvailableChatRooms
{
    PFQuery *query = [PFQuery queryWithClassName:@"ChatRoom"];
    [query whereKey:@"user1" equalTo:[PFUser currentUser]];
    PFQuery *queryInverse = [PFQuery queryWithClassName:@"ChatRoom"];
    [query whereKey:@"user2" equalTo:[PFUser currentUser]];
    PFQuery *queryCombined = [PFQuery orQueryWithSubqueries:@[query, queryInverse]];
    [queryCombined includeKey:@"chat"];
    [queryCombined includeKey:@"user1"];
    [queryCombined includeKey:@"user2"];
    [queryCombined findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self.availableChatRooms removeAllObjects];
            self.availableChatRooms = [objects mutableCopy];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UITableView DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.availableChatRooms count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFObject *chatRoom = [self.availableChatRooms objectAtIndex:indexPath.row];
    
    PFUser *likedUser;
    PFUser *currentUser = [PFUser currentUser];
    PFUser *testUser1 = chatRoom[@"user1"];
    if ([testUser1.objectId isEqual:currentUser.objectId]) {
        likedUser = [chatRoom objectForKey:@"user2"];
    }
    else {
        likedUser = [chatRoom objectForKey:@"user1"];
    }
    
    cell.textLabel.text = likedUser[@"profile"][@"firstName"];
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    PFQuery *queryForPhoto = [[PFQuery alloc] initWithClassName:@"Photo"];
    [queryForPhoto whereKey:@"user" equalTo:likedUser];
    [queryForPhoto findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] > 0) {
            PFObject *photo = objects[0];
            PFFile *pictureFile = photo[kPhotoPictureKey];
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                cell.imageView.image = [UIImage imageWithData:data];
                cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
            }];
        }
    }];
    
    return cell;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"matchesToChatSegue" sender:indexPath];
}






























































@end
