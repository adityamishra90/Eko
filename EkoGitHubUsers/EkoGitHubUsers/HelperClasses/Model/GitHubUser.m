//
//  GitHubUser.m
//  EkoGitHubUsers
//
//  Created by videotap ios on 14/01/20.
//  Copyright © 2020 videotap ios. All rights reserved.
//

#import "GitHubUser.h"

@implementation GitHubUser

- (GitHubUser *)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.nameUser = [dictionary objectForKey:@"login"];
        self.linkUser = [dictionary objectForKey:@"html_url"];
        self.userId   = [[dictionary objectForKey:@"id"] integerValue];
        self.accType  =  [dictionary objectForKey:@"type"];
        self.siteAdmin = [dictionary objectForKey:@"site_admin"];
        NSString *avatarString = [dictionary objectForKey:@"avatar_url"];
        self.avatarURL = [NSURL URLWithString:avatarString];
    }
    return self;
}

@end
