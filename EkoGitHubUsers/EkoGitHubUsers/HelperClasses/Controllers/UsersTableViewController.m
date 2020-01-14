//
//  UsersTableViewController.m
//  EkoGitHubUsers
//
//  Created by videotap ios on 14/01/20.
//  Copyright © 2020 videotap ios. All rights reserved.
//

#import "UsersTableViewController.h"
#import "GHUWebViewController.h"
#import "UserTableViewCell.h"
#import "GitHubUser.h"
#import "ServiceStore.h"
#import "UIKit+AFNetworking.h"
#import <CoreData/CoreData.h>
#import "Users+CoreDataClass.h"
@interface UsersTableViewController ()

@property (strong, nonatomic) NSMutableArray *gitHubUsers;
@property (strong, nonatomic) NSMutableArray *lastUsers;
@property (assign, nonatomic) BOOL loadingData;
@property (strong, nonatomic) NSMutableArray *getFavArray;
@property (retain,nonatomic) NSFetchedResultsController *
fetchedResultsController;
@property(retain,nonatomic)AppDelegate *appDelegate;

@end

@implementation UsersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.gitHubUsers = [NSMutableArray array];
    [self getUsersFromServer];
    self.loadingData = YES;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void)getUsersFromServer {
    
    GitHubUser *lastUser = [self.gitHubUsers lastObject];
    
    [[ServiceStore sharedManager] getAllUsersSince:lastUser.userId success:^(NSArray *users) {
        
        [self.gitHubUsers addObjectsFromArray:users];
        
        NSMutableArray *newPaths = [NSMutableArray array];
        for (int i = (int)[self.gitHubUsers count] - (int)[users count]; i < [self.gitHubUsers count]; i++) {
            [newPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
        }
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
        self.loadingData = NO;
        
    } failure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"%ld: %@",  (long)statusCode, [error localizedDescription]);
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.gitHubUsers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserCell"];
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Users"];
    self.getFavArray = [[_appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSLog(@"%@",self.getFavArray);
    cell.avatarButton.tag = indexPath.row;
    cell.fvrtButton.tag = indexPath.row;
    GitHubUser *gitHubUser = [self.gitHubUsers objectAtIndex:indexPath.row];

    cell.nameLabel.text = [NSString stringWithFormat:@"%s"@"%@","Name: ",gitHubUser.nameUser];
    cell.linkUser.text = [NSString stringWithFormat:@"%s"@"%@","Url: ",gitHubUser.linkUser];
    cell.accType.text = [NSString stringWithFormat:@"%s"@"%@","A/C Type: ",gitHubUser.accType];
    if (gitHubUser.siteAdmin) {
        cell.siteAdmin.text = [NSString stringWithFormat:@"%s"@"%@","Admin Status: ",@"Yes"];
    }
    else
    {
        cell.siteAdmin.text = [NSString stringWithFormat:@"%s"@"%@","Admin Status: ",@"No"];
    }
    if (self.getFavArray.count == 0) {
        [cell.fvrtButton setImage:[UIImage imageNamed:@"no-favorite-icon.png"] forState:UIControlStateNormal];
    }
    else
    {
       
            NSString *gettag = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
            if ([self CheckTagsexistorNot:gettag] == YES) {
                [cell.fvrtButton setImage:[UIImage imageNamed:@"favorite-icon.png"] forState:UIControlStateNormal];
            }
            else
            {
                [cell.fvrtButton setImage:[UIImage imageNamed:@"no-favorite-icon.png"] forState:UIControlStateNormal];
            }
    }
    cell.user = gitHubUser;
    
    __weak UserTableViewCell *weakCell = cell;
    NSURLRequest *request = [NSURLRequest requestWithURL:gitHubUser.avatarURL];
    
    
    cell.imageView.image = nil;
    
    [cell.imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [weakCell.avatarButton setImage:image forState:UIControlStateNormal];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"failed to load user image");
    }];
    
    //TODO: Refactor code to cell's function
    //[cell configureCell:gitHubUser];
    
    return cell;
}

-(BOOL) CheckTagsexistorNot:(NSString*) tagsvalue
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Users"];
    NSPredicate *newPredicate = [NSPredicate predicateWithFormat:@"tagstrvalue == %@",tagsvalue];
    [fetchRequest setPredicate:newPredicate];
    NSArray* objectsarr = [_appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    Users* user = [objectsarr lastObject];
    if (user != nil) {
        return YES;
    }

    return NO;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height / 1.3f) {
        if (!self.loadingData) {
            self.loadingData = YES;
            [self getUsersFromServer];
        }
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowAvatar"]) {
        GHUWebViewController *detailVC = [segue destinationViewController];

        GitHubUser *user = self.gitHubUsers[[sender tag]];
        detailVC.user = user;
    }
}



@end












