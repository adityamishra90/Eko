//
//  GitHubUser.h
//  EkoGitHubUsers
//
//  Created by videotap ios on 14/01/20.
//  Copyright © 2020 videotap ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitHubUser : NSObject

@property (strong, nonatomic) NSString *nameUser;
@property (strong, nonatomic) NSString *linkUser;
@property (strong, nonatomic) NSString *siteAdmin;
@property (strong, nonatomic) NSString *accType;
@property (strong, nonatomic) NSURL *avatarURL;
@property (assign, nonatomic) NSInteger userId;

- (GitHubUser *)initWithDictionary:(NSDictionary *)dictionary;

@end
