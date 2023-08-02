//
//  LNViewHierarchyDumper+LibrarySupport.h
//  ViewHierarchyDumpTester
//
//  Created by Leo Natan on 02/08/2023.
//

#import "LNViewHierarchyDumper.h"

NS_ASSUME_NONNULL_BEGIN

#if TARGET_OS_IPHONE && !TARGET_OS_MACCATALYST

@interface NSTask : NSObject @end

@interface NSTask ()

@property (nullable, copy) NSURL* executableURL;
@property (nullable, copy) NSArray<NSString*>* arguments;
@property (nullable, copy) NSDictionary<NSString*, NSString*>* environment;
@property (nullable, retain) id standardOutput;
@property (nullable, retain) id standardError;

@property(readonly) int terminationStatus;

@property(copy, nonnull) void (^terminationHandler)(NSTask* _Nonnull task);

- (BOOL)launch;

@end

#endif

@interface NSObject ()

//DBGTargetHub
+ (id)sharedHub;
- (NSData*)performRequestWithRequestInBase64:(NSString*)arg1;

//DebugHierarchyTargetHub
- (nullable id)performRequest:(id /*DBGTargetHub*/)arg1 error:(NSError**)error;

//DebugHierarchyRequest
+ (nullable id)requestWithBase64Data:(NSString*)arg1 error:(NSError**)arg2;

//NSTask
- (BOOL)launchAndReturnError:(out NSError **_Nullable)error;

@end

@interface LNViewHierarchyDumper (LibrarySupport)

+ (NSURL*)_xcodeURLOrError:(out NSError* __strong * _Nullable)outError;
+ (nullable NSURL*)_debugHierarchyFoundationFrameworkURL:(NSURL*)runtimeURL error:(out NSError** _Nullable)error;
+ (nullable NSURL*)_libViewDebuggerSupportURL:(NSURL*)runtimeURL error:(out NSError** _Nullable)error;

@end

NS_ASSUME_NONNULL_END
