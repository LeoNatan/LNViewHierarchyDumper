//
//  LNViewHierarchyDumper.m
//  LNViewHierarchyDumper
//
//  Created by Leo Natan (Wix) on 7/3/20.
//

#import "LNViewHierarchyDumper-Private.h"
#import "LNViewHierarchyDumper+LibrarySupport.h"
#if TARGET_OS_IPHONE || TARGET_OS_MACCATALYST
#import "LNViewHierarchyDumper+PhaseSupport_iOS.h"
#else
#import "LNViewHierarchyDumper+PhaseSupport_macOS.h"
#endif
#import "NSData+GZIP.h"

@import Darwin;
@import MachO.dyld;

#if TARGET_OS_MACCATALYST || TARGET_OS_OSX
@import AppKit;
#endif

#if defined(__IPHONE_14_0) || defined(__MAC_10_16) || defined(__MAC_11_0) || defined(__TVOS_14_0) || defined(__WATCHOS_7_0)
__attribute__((objc_direct_members))
#endif
@implementation LNViewHierarchyDumper
{
	BOOL _isFrameworkLoaded;
	NSError* _loadError;
}

+ (LNViewHierarchyDumper *)sharedDumper
{
	static LNViewHierarchyDumper* rv = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		rv = [[LNViewHierarchyDumper alloc] _init];
	});
	return rv;
}

- (instancetype)init
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (instancetype)_init
{
	self = [super init];
	
	if(self)
	{
		[self _loadDebugHierarchyFoundationFramework];
	}
	
	return self;
}

- (void)_loadDebugHierarchyFoundationFramework
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
#if TARGET_OS_IPHONE || TARGET_OS_MACCATALYST || TARGET_OS_OSX
#if TARGET_OS_IPHONE && !TARGET_OS_MACCATALYST
#if TARGET_OS_SIMULATOR
		NSBundle* someSimulatorBundle = [NSBundle bundleForClass:NSObject.class];
		NSURL* runtimeURL = [[someSimulatorBundle.bundleURL URLByAppendingPathComponent:@"../.."] URLByStandardizingPath];
#else
		NSURL* runtimeURL = nil;
#endif
#else
		NSURL* runtimeURL = [LNViewHierarchyDumper _xcodeURLOrError:&_loadError];
		if(runtimeURL == nil)
		{
			_isFrameworkLoaded = NO;
			return;
		}
#endif
		NSError* error;
		NSURL* bundleURL = [LNViewHierarchyDumper _debugHierarchyFoundationFrameworkURL:runtimeURL error:&error];
		NSURL* libViewDebuggerSupportURL = [LNViewHierarchyDumper _libViewDebuggerSupportURL:runtimeURL error:&error];
		
		if(error != nil)
		{
			_isFrameworkLoaded = NO;
			_loadError = error;
			return;
		}
		
		NSBundle* bundleToLoad = [NSBundle bundleWithURL:bundleURL];
		_isFrameworkLoaded = [bundleToLoad loadAndReturnError:&error];
		_loadError = error;
		
		if(NULL == dlopen(libViewDebuggerSupportURL.path.UTF8String, RTLD_NOW))
		{
			_isFrameworkLoaded = NO;
			_loadError = [NSError errorWithDomain:@"LNViewHierarchyDumperDomain" code:0 userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Unable to load %@: %s", libViewDebuggerSupportURL.lastPathComponent, dlerror()]}];
		}
#else
		_isFrameworkLoaded = NO;
		_loadError = [NSError errorWithDomain:@"LNViewHierarchyDumperDomain" code:0 userInfo:@{NSLocalizedDescriptionKey: @"LNViewHierarchyDumper is only supported on simulators, Catalyst and macOS (with Xcode installed)"}];
#endif
	});
}

- (nullable NSDictionary*)_executeRequestPhaseWithRequest:(NSDictionary*)request hub:(id /*DebugHierarchyTargetHub*/)sharedHub outputURL:(NSURL*)outputURL phaseCount:(NSInteger)count error:(NSError**)error
{
	NSData* phaseJsonData = [NSJSONSerialization dataWithJSONObject:request options:0 error:error];
	RETURN_NIL_IF_NIL(phaseJsonData);
	
	id phaseRequest = [NSClassFromString(@"DebugHierarchyRequest") requestWithBase64Data:[phaseJsonData base64EncodedStringWithOptions:0] error:error];
	RETURN_NIL_IF_NIL(phaseRequest);
	NSData* phaseResponseData = [sharedHub performRequest:phaseRequest error:error];
	RETURN_NIL_IF_NIL(phaseResponseData);
	if(count >= 0)
	{
		BOOL didWrite = [phaseResponseData writeToURL:[outputURL URLByAppendingPathComponent:[NSString stringWithFormat:@"Response_%@", @(count)]] options:NSDataWritingAtomic error:error];
		RETURN_NIL_IF_FALSE(didWrite);
	}
	
	phaseResponseData = phaseResponseData.isGzippedData ? phaseResponseData.gunzippedData : phaseResponseData;
	
	return [NSJSONSerialization JSONObjectWithData:phaseResponseData options:0 error:error];
}

- (BOOL)dumpViewHierarchyToURL:(NSURL*)URL error:(out NSError** _Nullable)error
{
#if TARGET_OS_IPHONE || TARGET_OS_MACCATALYST || TARGET_OS_OSX
	if(_isFrameworkLoaded == NO)
	{
#endif
		if(error) { *error = _loadError; }

		return NO;
#if TARGET_OS_IPHONE || TARGET_OS_MACCATALYST || TARGET_OS_OSX
	}
	
	if([URL.lastPathComponent hasSuffix:@".viewhierarchy"] == NO)
	{
		URL = [URL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@[%@].viewhierarchy", NSProcessInfo.processInfo.processName, @(NSProcessInfo.processInfo.processIdentifier)] isDirectory:YES];
	}
	
	if([NSFileManager.defaultManager fileExistsAtPath:URL.path])
	{
		RETURN_NO_IF_FALSE([NSFileManager.defaultManager removeItemAtURL:URL error:error]);
	}
	
	RETURN_NO_IF_FALSE([NSFileManager.defaultManager createDirectoryAtURL:URL withIntermediateDirectories:YES attributes:nil error:error]);
	
	id sharedHub = [NSClassFromString(@"DebugHierarchyTargetHub") sharedHub];
	RETURN_NO_IF_NIL(sharedHub);
	
	RETURN_NO_IF_FALSE([self _startPhasesWithHub:sharedHub outputURL:URL error:error]);
	
	return YES;
#endif
}

@end
