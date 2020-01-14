//
//  ServiceStore.h
//  EkoGitHubUsers
//
//  Created by videotap ios on 15/01/20.
//  Copyright © 2020 videotap ios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServiceStore : NSObject
+ (ServiceStore *)sharedManager;

- (void)getAllUsersSince:(NSInteger)since success:(void(^)(NSArray *users))success failure:(void(^)(NSError *error, NSInteger statusCode))failure;
@end

NS_ASSUME_NONNULL_END
