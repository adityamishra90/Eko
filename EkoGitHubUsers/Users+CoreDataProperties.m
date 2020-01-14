//
//  Users+CoreDataProperties.m
//  
//
//  Created by videotap ios on 15/01/20.
//
//

#import "Users+CoreDataProperties.h"

@implementation Users (CoreDataProperties)

+ (NSFetchRequest<Users *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Users"];
}

@dynamic tagstrvalue;

@end
