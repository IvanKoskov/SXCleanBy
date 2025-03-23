//
//  cachesManager.h
//  SXCleanBy
//
// Created by Ivan Koskov (aka Evan Matthew) on 23/3/2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface cachesManager : NSObject

@property NSArray<NSString *>* defaultCachesDirs;

-(void)initWithDefaults;

-(BOOL)deleteCachesFrom:(NSArray<NSString *> *)ProvidedcachesArray;

-(NSArray *)getAllFilesFoldersFromThedir:(NSString *)directory;

@end

NS_ASSUME_NONNULL_END
