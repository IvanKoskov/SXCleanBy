//
//  cachesManager.m
//  SXCleanBy
//
//  Created by Ivan Koskov (aka Evan Matthew) on 23/3/2025.
//

#import "cachesManager.h"

@implementation cachesManager

- (void)initWithDefaults {

    
    //Static paths to caches
    //note: WE NEED MORE
    self.defaultCachesDirs = @[
           [@"~/Library/Caches/CocoaPods" stringByExpandingTildeInPath],
           [@"~/Library/Caches/org.carthage.CarthageKit" stringByExpandingTildeInPath],
           [@"~/Library/Caches/Homebrew" stringByExpandingTildeInPath],
           [@"~/Library/Logs/Homebrew/" stringByExpandingTildeInPath],
           [@"~/.npm" stringByExpandingTildeInPath],
           [@"~/Library/Developer/Xcode/DerivedData" stringByExpandingTildeInPath],
           [@"~/Library/Caches/Yarn" stringByExpandingTildeInPath],
           [@"~/Library/Caches/Google/Chrome" stringByExpandingTildeInPath],
           [@"~/Library/Application Support/Google/Chrome" stringByExpandingTildeInPath],
           [@"~/Library/Caches/com.google.Chrome" stringByExpandingTildeInPath],
           [@"~/Library/Caches/Firefox" stringByExpandingTildeInPath],
           [@"~/Library/Caches/org.mozilla.firefox" stringByExpandingTildeInPath],
           [@"~/Library/testingSXclean" stringByExpandingTildeInPath]
       ];
    
   
}

- (BOOL)deleteCachesFrom:(NSArray<NSString *> *)ProvidedcachesArray {
    // Method will clean everything inside the provided directories recursively, including the directories themselves.
    // Example of the path will look like: ~/Library/Logs/Homebrew/ and so on
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    for (NSString *cachePath in ProvidedcachesArray) {
        NSError *error = nil;
        
        // Check if the directory exists at the specified path
        if ([fileManager fileExistsAtPath:cachePath]) {
            
            // Get the contents of the directory
            NSArray *contents = [fileManager contentsOfDirectoryAtPath:cachePath error:&error];
            
            if (error) {
                NSLog(@"Error fetching contents of directory %@: %@", cachePath, error.localizedDescription);
                return NO;
            }
            
            // Iterate over each item in the directory
            for (NSString *fileName in contents) {
                NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
                
                BOOL isDirectory;
                if ([fileManager fileExistsAtPath:filePath isDirectory:&isDirectory]) {
                    if (isDirectory) {
                        // If it's a directory, recursively delete everything inside it (including the directory)
                        if (![self deleteCachesFrom:@[filePath]]) {
                            return NO; // Failed to delete contents of a directory
                        }
                        // Now delete the directory itself
                        NSError *deleteError = nil;
                        if (![fileManager removeItemAtPath:filePath error:&deleteError]) {
                            NSLog(@"Error deleting directory %@: %@", filePath, deleteError.localizedDescription);
                            return NO;
                        }
                    } else {
                        // If it's a file, delete it
                        NSError *deleteError = nil;
                        if (![fileManager removeItemAtPath:filePath error:&deleteError]) {
                            NSLog(@"Error deleting file %@: %@", filePath, deleteError.localizedDescription);
                            return NO;
                        }
                    }
                }
            }
            
            // Now delete the provided directory itself
            NSError *deleteError = nil;
            if (![fileManager removeItemAtPath:cachePath error:&deleteError]) {
                NSLog(@"Error deleting directory %@: %@", cachePath, deleteError.localizedDescription);
                return NO;
            }
        } else {
            NSLog(@"Directory does not exist: %@", cachePath);
            return NO;
        }
    }
    
    return YES; // Success
}



- (NSArray *)getAllFilesFoldersFromThedir:(nonnull NSString *)directory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    
    // Corrected error handling by passing a pointer to NSError
    NSArray *dirContents = [fileManager contentsOfDirectoryAtPath:directory error:&error];
    
    if (error) {
        // Handle the error (for example, print it or return nil)
        NSLog(@"Error reading directory: %@", error.localizedDescription);
        return nil;
    }
    
    return dirContents;
}


@end
