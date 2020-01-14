//
//  Users+CoreDataProperties.h
//  
//
//  Created by videotap ios on 15/01/20.
//
//

#import "Users+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Users (CoreDataProperties)

+ (NSFetchRequest<Users *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *tagstrvalue;

@end

NS_ASSUME_NONNULL_END
