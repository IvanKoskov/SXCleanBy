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
           [@"~/Library/Caches/org.mozilla.firefox" stringByExpandingTildeInPath]
       ];
    
   
}

@end
