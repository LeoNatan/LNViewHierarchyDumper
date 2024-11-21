//
//  LNViewHierarchyDumper+LibraryDebug.m
//  
//
//  Created by Leo Natan on 02/08/2023.
//

#import "LNViewHierarchyDumper+LibraryDebug.h"

#define DEBUG_FRAMEWORKLOAD 0
#define DEBUG_REQUESTS 0
#define DEBUG_REQUESTS_REMOVE_COMPRESSION 1

#if DEBUG_FRAMEWORKLOAD || DEBUG_REQUESTS

#if DEBUG
@import ObjectiveC;
@import Darwin;
@import MachO.dyld;
#endif

@implementation LNViewHierarchyDumper (LibraryDebug)

#if DEBUG
#if DEBUG_FRAMEWORKLOAD
static void func(const struct mach_header* mh, intptr_t vmaddr_slide)
{
	Dl_info  DlInfo;
	dladdr(mh, &DlInfo);
	const char* image_name = DlInfo.dli_fname;

	NSLog(@"%s", image_name);
}
#endif

#if DEBUG_REQUESTS
static NSUInteger requestCounter = 0;
static NSUInteger responseCounter = 0;
#endif

__attribute__((constructor))
static void zzz(void)
{
#if DEBUG_FRAMEWORKLOAD
	//We are looking for:
	//	DebugHierarchyFoundation.framework
	//	libViewDebuggerSupport.dylib
	_dyld_register_func_for_add_image(func);
#endif

#if DEBUG_REQUESTS
	//The following code will dump requests made by Xcode View Hierarchy Inspector (and this framework) to ~/Desktop/Request_x.json
	{
		Class cls = NSClassFromString(@"DebugHierarchyRequest");
		SEL sel = NSSelectorFromString(@"requestWithBase64Data:error:");
		Method m = class_getClassMethod(cls, sel);
		id(*orig)(id, SEL, NSString*, NSError**) = (void*)method_getImplementation(m);

		method_setImplementation(m, imp_implementationWithBlock(^(id _self, NSString* request, NSError** error) {
			NSData* b64Data = [[NSData alloc] initWithBase64EncodedString:request options:0];
			
#if DEBUG_REQUESTS_REMOVE_COMPRESSION
			NSMutableDictionary* r = [NSJSONSerialization JSONObjectWithData:b64Data options:NSJSONReadingMutableContainers error:NULL];
			r[@"DBGHierarchyRequestTransportCompression"] = @NO;
			NSLog(@"%@", r);
			b64Data = [NSJSONSerialization dataWithJSONObject:r options:0 error:NULL];
			request = [b64Data base64EncodedStringWithOptions:0];
#endif
			
			NSString* homePath = NSHomeDirectory();
#if TARGET_OS_SIMULATOR
			homePath = [homePath substringToIndex:[homePath rangeOfString:@"/Library"].location];
#endif
			NSURL* outputURL = [[NSURL fileURLWithPath:homePath] URLByAppendingPathComponent:[NSString stringWithFormat:@"Desktop/Request_%@.json", @(requestCounter++)]];
			
//			NSLog(@"%@", outputURL.path);
//			NSLog(@"%@", NSThread.callStackSymbols);
			
			[b64Data writeToURL:outputURL atomically:YES];

			return orig(_self, sel, request, error);
		}));
	}

	{
		Class cls = NSClassFromString(@"DebugHierarchyTargetHub");
		SEL sel = NSSelectorFromString(@"performRequest:error:");
		Method m = class_getInstanceMethod(cls, sel);
		NSData*(*orig)(id, SEL, id, NSError**) = (void*)method_getImplementation(m);
		method_setImplementation(m, imp_implementationWithBlock(^(id _self, id request, NSError** error) {
			NSData* rv = orig(_self, sel, request, error);

			if(rv != nil)
			{
				NSString* homePath = NSHomeDirectory();
#if TARGET_OS_SIMULATOR
				homePath = [homePath substringToIndex:[homePath rangeOfString:@"/Library"].location];
#endif
				NSURL* outputURL = [[NSURL fileURLWithPath:homePath] URLByAppendingPathComponent:[NSString stringWithFormat:@"Desktop/Response_%@.json", @(responseCounter++)]];
				[rv writeToURL:outputURL atomically:YES];
			}

			return rv;
		}));
	}
#endif
}
#endif

@end

#endif
