//
//  GhuUtils.h
//  EkoGitHubUsers
//
//  Created by videotap ios on 14/01/20.
//  Copyright © 2020 videotap ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GHUUtils : NSObject

+ (UIActivityIndicatorView*)startSpinnerAtView:(UIView*)view;
+ (void)stopSpinner:(UIActivityIndicatorView*)spinner;

@end
