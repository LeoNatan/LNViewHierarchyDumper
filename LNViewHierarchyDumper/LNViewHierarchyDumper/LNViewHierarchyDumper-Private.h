//
//  Header.h
//  
//
//  Created by Leo Natan on 02/08/2023.
//

#import <LNViewHierarchyDumper/LNViewHierarchyDumper.h>

#define GENERIC_ERROR_IF_NEEDED() if(error && !*error) { *error = [NSError errorWithDomain:@"LNViewHierarchyDumperDomain" code:0 userInfo:@{NSLocalizedDescriptionKey: @"Unknown error encountered; try restarting your simulator, Xcode or Mac (reminder: this framework is as buggy as or as bug-free as Xcode's visual inspector infrastructure.)"}]; }
#define RETURN_IF_FALSE(cmd) if((cmd) == NO) { GENERIC_ERROR_IF_NEEDED(); return NO; }
#define RETURN_IF_NIL(cmd) if((cmd) == nil) { GENERIC_ERROR_IF_NEEDED(); return NO; }

NS_ASSUME_NONNULL_BEGIN

@interface LNViewHierarchyDumper ()

- (nullable NSDictionary*)_executeRequestPhaseWithRequest:(NSDictionary*)request hub:(id /*DebugHierarchyTargetHub*/)sharedHub outputURL:(NSURL*)outputURL phaseCount:(NSInteger)count error:(NSError**)error;

@end

NS_ASSUME_NONNULL_END
