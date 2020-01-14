//
//  UserTableViewCell.m
//  EkoGitHubUsers
//
//  Created by videotap ios on 14/01/20.
//  Copyright © 2020 videotap ios. All rights reserved.
//

#import "UserTableViewCell.h"
#import <CoreData/CoreData.h>
#import "Users+CoreDataClass.h"
@implementation UserTableViewCell

#pragma mark - Action
- (IBAction)FavouriteButtonClicked:(UIButton *)sender {
    NSLog(@"%ld",(long)sender.tag);
   _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    NSString *getTag = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    if (self.fvrtButton.currentImage == [UIImage imageNamed:@"favorite-icon.png"]) {
        [self.fvrtButton setImage:[UIImage imageNamed:@"no-favorite-icon.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        [self.fvrtButton setImage:[UIImage imageNamed:@"favorite-icon.png"] forState:UIControlStateNormal];
        Users* user = [NSEntityDescription insertNewObjectForEntityForName:@"Users"
                                                   inManagedObjectContext:_appDelegate.managedObjectContext];
        user.tagstrvalue = getTag;
        [_appDelegate saveContext];
    }
    
    
    
}

@end
