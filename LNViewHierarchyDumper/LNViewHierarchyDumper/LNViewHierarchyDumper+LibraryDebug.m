//
//  LNViewHierarchyDumper+LibraryDebug.m
//  
//
//  Created by Leo Natan on 02/08/2023.
//

#import "LNViewHierarchyDumper+LibraryDebug.h"

//#if DEBUG
//@import ObjectiveC;
//@import Darwin;
//@import MachO.dyld;
//#endif

@implementation LNViewHierarchyDumper (LibraryDebug)

//#if DEBUG
//static void func(const struct mach_header* mh, intptr_t vmaddr_slide)
//{
//	Dl_info  DlInfo;
//	dladdr(mh, &DlInfo);
//	const char* image_name = DlInfo.dli_fname;
//
//	NSLog(@"%s", image_name);
//}
//
//
//static NSUInteger requestCounter = 0;
//static NSUInteger responseCounter = 0;
//
//__attribute__((constructor))
//static void zzz(void)
//{
//	//We are looking for:
//	//	DebugHierarchyFoundation.framework
//	//	libViewDebuggerSupport.dylib
//	_dyld_register_func_for_add_image(func);
//
//	//The following code will dump requests made by Xcode View Hierarchy Inspector (and this framework) to ~/Desktop/Request_x.json
//	{
//		Class cls = NSClassFromString(@"DebugHierarchyRequest");
//		SEL sel = NSSelectorFromString(@"requestWithBase64Data:error:");
//		Method m = class_getClassMethod(cls, sel);
//		id(*orig)(id, SEL, NSString*, NSError**) = (void*)method_getImplementation(m);
//
//		method_setImplementation(m, imp_implementationWithBlock(^(id _self, NSString* request, NSError** error) {
//			NSData* b64Data = [[NSData alloc] initWithBase64EncodedString:request options:0];
//			NSString* homePath = NSHomeDirectory();
//#if TARGET_OS_SIMULATOR
//			homePath = [homePath substringToIndex:[homePath rangeOfString:@"/Library"].location];
//#endif
//			NSLog(@"%@", homePath);
//			NSURL* outputURL = [[NSURL fileURLWithPath:homePath] URLByAppendingPathComponent:[NSString stringWithFormat:@"Desktop/Request_%@.json", @(requestCounter++)]];
//			[b64Data writeToURL:outputURL atomically:YES];
//
//			return orig(_self, sel, request, error);
//		}));
//	}
//
//	{
//		Class cls = NSClassFromString(@"DebugHierarchyTargetHub");
//		SEL sel = NSSelectorFromString(@"performRequest:error:");
//		Method m = class_getInstanceMethod(cls, sel);
//		NSData*(*orig)(id, SEL, id, NSError**) = (void*)method_getImplementation(m);
//		method_setImplementation(m, imp_implementationWithBlock(^(id _self, id request, NSError** error) {
//			NSData* rv = orig(_self, sel, request, error);
//
//			if(rv != nil)
//			{
//				NSString* homePath = NSHomeDirectory();
//#if TARGET_OS_SIMULATOR
//				homePath = [homePath substringToIndex:[homePath rangeOfString:@"/Library"].location];
//#endif
//				NSURL* outputURL = [[NSURL fileURLWithPath:homePath] URLByAppendingPathComponent:[NSString stringWithFormat:@"Desktop/Response_%@.json", @(responseCounter++)]];
//				[rv writeToURL:outputURL atomically:YES];
//			}
//
//			return rv;
//		}));
//	}
//}
//#endif

@end
