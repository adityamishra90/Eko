//
//  ServiceStore.m
//  EkoGitHubUsers
//
//  Created by videotap ios on 15/01/20.
//  Copyright © 2020 videotap ios. All rights reserved.
//

#import "ServiceStore.h"
#import "AFNetworking.h"
#import "GitHubUser.h"

@interface ServiceStore ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation ServiceStore

+ (ServiceStore *)sharedManager {
    static ServiceStore *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServiceStore alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:@"https://api.github.com"];
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    return self;
}

#pragma mark - API

- (void)getAllUsersSince:(NSInteger)since success:(void(^)(NSArray *users))success failure:(void(^)(NSError *error, NSInteger statusCode))failure {
    
    NSString *stringSince = [NSString stringWithFormat:@"%ld", (long)since];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                stringSince, @"since",
                                nil];
    
    [self.manager GET:@"/users?per_page=100" parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSArray *dictionariesArray = responseObject;
        NSMutableArray *usersArray = [NSMutableArray array];

        for (NSDictionary *dictionary in dictionariesArray) {
            GitHubUser *gitHubUser = [[GitHubUser alloc] initWithDictionary:dictionary];
            [usersArray addObject:gitHubUser];
        }

        if (success) {
            success(usersArray);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

@end


















