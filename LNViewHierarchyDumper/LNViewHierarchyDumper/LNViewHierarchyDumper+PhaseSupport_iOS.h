//
//  LNViewHierarchyDumper+PhaseSupport_iOS.h
//  
//
//  Created by Leo Natan on 02/08/2023.
//

#import "LNViewHierarchyDumper-Private.h"

#if TARGET_OS_IPHONE || TARGET_OS_MACCATALYST

NS_ASSUME_NONNULL_BEGIN

NSArray<NSString*>* LNExtractPhoneOSPhase1ForPhase2ResponseObjects(NSDictionary* phase1Response);
NSArray<NSString*>* LNExtractPhoneOSPhase1ForPhase3ResponseObjects(NSDictionary* phase1Response);
NSArray<NSString*>* LNExtractPhoneOSPhase1ForPhase4ResponseObjects(NSDictionary* phase1Response);

@interface LNViewHierarchyDumper (PhaseSupport_iOS)

- (BOOL)_startPhasesWithHub:(id /*DebugHierarchyTargetHub*/)sharedHub outputURL:(NSURL*)outputURL error:(NSError**)error;

@end

NS_ASSUME_NONNULL_END

#endif
