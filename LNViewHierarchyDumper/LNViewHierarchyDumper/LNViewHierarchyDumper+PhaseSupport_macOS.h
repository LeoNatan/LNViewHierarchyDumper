//
//  LNViewHierarchyDumper+PhaseSupport_macOS.h
//  
//
//  Created by Leo Natan on 02/08/2023.
//

#import "LNViewHierarchyDumper.h"

#if TARGET_OS_OSX

NS_ASSUME_NONNULL_BEGIN

NSArray<NSString*>* LNExtractMacOSPhase1ForPhase2ResponseObjects(NSDictionary* phase1Response);

@interface LNViewHierarchyDumper (PhaseSupport_macOS)

- (BOOL)_startPhasesWithHub:(id /*DebugHierarchyTargetHub*/)sharedHub outputURL:(NSURL*)outputURL error:(NSError**)error;

@end

NS_ASSUME_NONNULL_END

#endif
