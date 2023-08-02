//
//  LNViewHierarchyDumper+LibrarySupport.m
//  ViewHierarchyDumpTester
//
//  Created by Leo Natan on 02/08/2023.
//

#import "LNViewHierarchyDumper+LibrarySupport.h"

@implementation LNViewHierarchyDumper (LibrarySupport)

+ (BOOL)_isMacSandboxed
{
	return NSProcessInfo.processInfo.environment[@"APP_SANDBOX_CONTAINER_ID"].length > 0;
}

+ (NSURL*)_xcodeURLOrError:(out NSError* __strong * _Nullable)outError
{
	static NSURL* rv = nil;
	static NSError* error = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		if(self._isMacSandboxed)
		{
			rv = [NSURL fileURLWithPath:@"/Applications/Xcode.app/Contents"];
			if([rv checkResourceIsReachableAndReturnError:NULL] == NO)
			{
				rv = [NSURL fileURLWithPath:@"/Applications/Xcode-beta.app/Contents"];
				if([rv checkResourceIsReachableAndReturnError:NULL] == NO)
				{
					rv = NULL;
					error = [NSError errorWithDomain:@"LNViewHierarchyDumperDomain" code:0 userInfo:@{NSLocalizedDescriptionKey: @"App is sandboxed and cannot find Xcode in\n/Applications/Xcode.app\nor\n/Applications/Xcode-beta.app"}];
					return;
				}
			}
		}
		else
		{
			NSTask* whichXcodeTask = [NSTask new];
			[whichXcodeTask setValue:[NSURL fileURLWithPath:@"/usr/bin/xcode-select"] forKey:@"executableURL"];
			whichXcodeTask.arguments = @[@"-p"];
			whichXcodeTask.environment = @{};
			
			NSPipe* outPipe = [NSPipe pipe];
			NSMutableData* outData = [NSMutableData new];
			whichXcodeTask.standardOutput = outPipe;
			outPipe.fileHandleForReading.readabilityHandler = ^(NSFileHandle * _Nonnull fileHandle) {
				[outData appendData:fileHandle.availableData];
			};
			
			NSPipe* errPipe = [NSPipe pipe];
			NSMutableData* errData = [NSMutableData new];
			whichXcodeTask.standardError = errPipe;
			errPipe.fileHandleForReading.readabilityHandler = ^(NSFileHandle * _Nonnull fileHandle) {
				[errData appendData:fileHandle.availableData];
			};
			
			dispatch_semaphore_t waitForTermination = dispatch_semaphore_create(0);
			
			[whichXcodeTask setValue:^(NSTask* _Nonnull task) {
				outPipe.fileHandleForReading.readabilityHandler = nil;
				errPipe.fileHandleForReading.readabilityHandler = nil;
				
				dispatch_semaphore_signal(waitForTermination);
			} forKey:@"terminationHandler"];
			
			NSError* taskError;
			[(id)whichXcodeTask launchAndReturnError:&taskError];
			
			if(taskError == nil)
			{
				dispatch_semaphore_wait(waitForTermination, DISPATCH_TIME_FOREVER);
			}
			else
			{
				error = taskError;
				return;
			}
			
			if(whichXcodeTask.terminationStatus != 0)
			{
				NSString* errString = [[NSString alloc] initWithData:errData encoding:NSUTF8StringEncoding];
				error = [NSError errorWithDomain:@"LNViewHierarchyDumperDomain" code:0 userInfo:@{NSLocalizedDescriptionKey: errString}];
				return;
			}
			
			NSString* xcodePath = [[[NSString alloc] initWithData:outData encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
			
			if(xcodePath.length == 0)
			{
				error = [NSError errorWithDomain:@"LNViewHierarchyDumperDomain" code:0 userInfo:@{NSLocalizedDescriptionKey: @"Unable to find the current active developer directory"}];
				
				return;
			}
			
			rv = [[[NSURL fileURLWithPath:xcodePath] URLByAppendingPathComponent:@".."] URLByStandardizingPath];
		}
	});
	if(outError != NULL)
	{
		*outError = error;
	}
	return rv;
}

+ (NSURL*)_debugHierarchyFoundationFrameworkURL_iOS:(NSURL*)runtimeURL
{
	NSString* rv = nil;
	if(@available(iOS 17, *))
	{
		rv = @"System/Library/PrivateFrameworks/DebugHierarchyFoundation.framework";
	}
	else
	{
		rv = @"Developer/Library/PrivateFrameworks/DebugHierarchyFoundation.framework";
	}
#if TARGET_OS_SIMULATOR
	return [runtimeURL URLByAppendingPathComponent:rv];
#else
	return [NSURL fileURLWithPath:[NSString stringWithFormat:@"/%@", rv]];
#endif
}

+ (NSURL*)_debugHierarchyFoundationFrameworkURL_macOS:(NSURL*)runtimeURL isCatalyst:(BOOL)isCatalyst
{
	return [runtimeURL URLByAppendingPathComponent:@"SharedFrameworks/DebugHierarchyFoundation.framework"];
}

+ (nullable NSURL*)_debugHierarchyFoundationFrameworkURL:(NSURL*)runtimeURL error:(out NSError** _Nullable)error
{
#if TARGET_OS_IPHONE && !TARGET_OS_MACCATALYST
	if (@available(iOS 14.0, *))
	{
		if(NSProcessInfo.processInfo.isiOSAppOnMac)
		{
			NSError* xcodeError = nil;
			NSURL* xcodeURL = [self _xcodeURLOrError:&xcodeError];
			if(xcodeError)
			{
				if(error) { *error = xcodeError; }
				return nil;
			}
			
			return [self _debugHierarchyFoundationFrameworkURL_macOS:xcodeURL isCatalyst:YES];
		}
	}
	return [self _debugHierarchyFoundationFrameworkURL_iOS:runtimeURL];
#else
#if TARGET_OS_MACCATALYST
	BOOL isCatalyst = YES;
#else
	BOOL isCatalyst = NO;
#endif
	return [self _debugHierarchyFoundationFrameworkURL_macOS:runtimeURL isCatalyst:isCatalyst];
#endif
}

+ (NSURL*)_libViewDebuggerSupportURL_iOS:(NSURL*)runtimeURL
{
	NSString* rv = nil;
	if(@available(iOS 17, *))
	{
		rv = @"usr/lib/libViewDebuggerSupport.dylib";
	}
	else
	{
		rv = @"Developer/Library/PrivateFrameworks/DTDDISupport.framework/libViewDebuggerSupport.dylib";
	}
#if TARGET_OS_SIMULATOR
	return [runtimeURL URLByAppendingPathComponent:rv];
#else
	return [NSURL fileURLWithPath:[NSString stringWithFormat:@"/%@", rv]];
#endif
}

+ (NSURL*)_libViewDebuggerSupportURL_macOS:(NSURL*)runtimeURL isCatalyst:(BOOL)isCatalyst
{
	NSString* libName = isCatalyst ? @"libViewDebuggerSupport_macCatalyst.dylib" : @"libViewDebuggerSupport.dylib";
	return [runtimeURL URLByAppendingPathComponent:[NSString stringWithFormat:@"Developer/Platforms/MacOSX.platform/Developer/Library/Debugger/%@", libName]];
}

+ (nullable NSURL*)_libViewDebuggerSupportURL:(NSURL*)runtimeURL error:(out NSError** _Nullable)error
{
#if TARGET_OS_IPHONE && !TARGET_OS_MACCATALYST
	if (@available(iOS 14.0, *))
	{
		if(NSProcessInfo.processInfo.isiOSAppOnMac)
		{
			NSError* xcodeError = nil;
			NSURL* xcodeURL = [self _xcodeURLOrError:&xcodeError];
			if(xcodeError)
			{
				if(error) { *error = xcodeError; }
				return nil;
			}
			
			return [self _libViewDebuggerSupportURL_macOS:xcodeURL isCatalyst:YES];
		}
	}
	return [self _libViewDebuggerSupportURL_iOS:runtimeURL];
#else
#if TARGET_OS_MACCATALYST
	BOOL isCatalyst = YES;
#else
	BOOL isCatalyst = NO;
#endif
	return [self _libViewDebuggerSupportURL_macOS:runtimeURL isCatalyst:isCatalyst];
#endif
}


@end
