//
//  UserTableViewCell.h
//  EkoGitHubUsers
//
//  Created by videotap ios on 14/01/20.
//  Copyright © 2020 videotap ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GitHubUser.h"
#import "AppDelegate.h"

@interface UserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *avatarButton;
@property (weak, nonatomic) IBOutlet UILabel  *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkUser;
@property (weak, nonatomic) IBOutlet UILabel *siteAdmin;
@property (weak, nonatomic) IBOutlet UILabel *accType;
@property (weak, nonatomic) IBOutlet UIButton *fvrtButton;

@property (strong, nonatomic) GitHubUser *user;
@property(weak,nonatomic) AppDelegate *appDelegate;
@property (strong,nonatomic) NSMutableArray *fvrtclick;
@end
