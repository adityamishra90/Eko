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
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Users"];
        NSPredicate *newPredicate = [NSPredicate predicateWithFormat:@"tagstrvalue == %@",getTag];
        [fetchRequest setPredicate:newPredicate];
        // Create batch delete request
        NSArray* objectsarr = [_appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil];
        if (objectsarr != nil)
        {
            for (NSManagedObject* object in objectsarr)
            {
                [_appDelegate.managedObjectContext deleteObject:object];

                //Reload/refresh table or whatever view..
            }

             [_appDelegate saveContext];
        }
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
