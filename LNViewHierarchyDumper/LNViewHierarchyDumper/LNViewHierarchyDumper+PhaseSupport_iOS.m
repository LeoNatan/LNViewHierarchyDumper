//
//  LNViewHierarchyDumper+PhaseSupport_iOS.m
//  
//
//  Created by Leo Natan on 02/08/2023.
//

#import "LNViewHierarchyDumper-Private.h"
#import "LNViewHierarchyDumper+PhaseSupport_iOS.h"

#if TARGET_OS_IPHONE || TARGET_OS_MACCATALYST

#define REMOVE_COMPRESSION 0

NSArray<NSString*>* LNExtractPhoneOSPhase0ForPhase1ResponseObjects(NSDictionary* phase1Response)
{
	NSArray<NSDictionary*>* topLevelGroupsCALayers = phase1Response[@"topLevelGroups"][@"com.apple.QuartzCore.CALayer"][@"debugHierarchyObjects"];
	
	return [topLevelGroupsCALayers valueForKey:@"objectID"];
}

void LNTraverseViews(NSArray* views, BOOL(^test)(NSDictionary* view), NSMutableArray* output)
{
	if(views.count == 0)
	{
		return;
	}
	
	for(NSDictionary* view in views)
	{
		if(test(view) == YES)
		{
			[output addObject:view[@"objectID"]];
		}
		
		LNTraverseViews(view[@"childGroup"][@"debugHierarchyObjects"], test, output);
	}
}

void LNFindViews(NSDictionary* phase0Response, BOOL(^test)(NSDictionary* view), NSMutableArray* output)
{
	void (^traverser)(NSArray* views) = ^(NSArray* views) {
		LNTraverseViews(views, test, output);
	};
	
	NSArray<NSDictionary*>* windows = phase0Response[@"topLevelGroups"][@"com.apple.UIKit.UIWindow"][@"debugHierarchyObjects"];
	for(NSDictionary* window in windows)
	{
		NSArray<NSDictionary*>* views = window[@"childGroup"][@"debugHierarchyObjects"];
		traverser(views);
	}
	
	NSArray<NSDictionary*>* views = phase0Response[@"topLevelGroups"][@"com.apple.UIKit.UIView"][@"debugHierarchyObjects"];
	traverser(views);
}

NSArray<NSString*>* LNExtractPhoneOSPhase0ForPhase2ResponseObjects(NSDictionary* phase0Response)
{
	NSMutableArray* rv = [NSMutableArray new];

	LNFindViews(phase0Response, ^BOOL(NSDictionary *view) {
		return [view[@"className"] isEqualToString:@"_UIVisualEffectBackdropView"];
	}, rv);
	
	return rv;
}

BOOL LNViewPropertyExistsWithKey(NSDictionary* view, NSString* key)
{
	NSArray* properties = view[@"properties"];
	for(NSDictionary* property in properties)
	{
		if([property[@"propertyName"] isEqualToString:key])
		{
			return YES;
		}
	}
	
	return NO;
}

NSArray<NSString*>* LNExtractPhoneOSPhase0ForPhase3ResponseObjects(NSDictionary* phase0Response)
{
	NSMutableArray* rv = [NSMutableArray new];
	
	LNFindViews(phase0Response, ^BOOL(NSDictionary *view) {
		return LNViewPropertyExistsWithKey(view, @"dbg_holdsSymbolImage");
	}, rv);
	
	return rv;
}

@implementation LNViewHierarchyDumper (PhaseSupport_iOS)

- (BOOL)_startPhasesWithHub:(id /*DebugHierarchyTargetHub*/)sharedHub outputURL:(NSURL*)outputURL error:(NSError**)error
{
	NSURL* requestResponses = [outputURL URLByAppendingPathComponent:@"RequestResponses" isDirectory:YES];
	RETURN_NO_IF_FALSE([NSFileManager.defaultManager createDirectoryAtURL:requestResponses withIntermediateDirectories:YES attributes:nil error:error]);
	
	//https://erkanyildiz.me/lab/jsonhardcode/
	NSDictionary* phase0Dictionary = @{
		@"DBGHierarchyRequestName": @"Initial request",
		@"DBGHierarchyRequestInitiatorVersionKey": @4,
		@"DBGHierarchyRequestPriority": @0,
		@"DBGHierarchyObjectDiscovery": @1,
		@"DBGHierarchyRequestActions": @[
			@{
				@"actionClass": @"DebugHierarchyResetAction"
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"dbgFormattedDisplayName"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": NSNull.null,
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"anchorPoint",
					@"anchorPointZ",
					@"bounds",
					@"contentsScale",
					@"doubleSided",
					@"frame",
					@"geometryFlipped",
					@"masksToBounds",
					@"name",
					@"opacity",
					@"opaque",
					@"position",
					@"sublayerTransform",
					@"transform",
					@"zPosition",
					@"dbg_ListID",
					@"optimizationOpportunities"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"CALayer"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"constant",
					@"firstAttribute",
					@"firstItem",
					@"identifier",
					@"multiplier",
					@"priority",
					@"relation",
					@"secondAttribute",
					@"secondItem"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"NSLayoutConstraint"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"anchorPoint",
					@"frame",
					@"hidden",
					@"position",
					@"untransformedSize",
					@"visualRepresentationOffset",
					@"xScale",
					@"yScale",
					@"zPosition",
					@"zRotation"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"SKNode"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"scaleMode",
					@"size"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"SKScene"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @1,
				@"propertyNames": NSNull.null,
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @3,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"SKView"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyActionLegacyV1",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @1,
				@"propertyNames": NSNull.null,
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @3,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"SKScene"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyActionLegacyV1",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @1,
				@"propertyNames": NSNull.null,
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @3,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"SKNode"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyActionLegacyV1",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"displayCornerRadius",
					@"nativeBounds",
					@"nativeDisplayBounds",
					@"nativeScale",
					@"scale",
					@"dbgScreenShape",
					@"dbgScreenShapeIsRectangular"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"UIScreen"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"keyWindow",
					@"statusBarOrientation"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"UIApplication"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"title",
					@"activationState"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"UIScene"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"title",
					@"internal",
					@"visible"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"UIWindow"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"title"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"UIViewController"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"alpha",
					@"ambiguityStatusMask",
					@"bounds",
					@"dbgViewForFirstBaselineLayout",
					@"dbgViewForLastBaselineLayout",
					@"firstBaselineOffsetFromTop",
					@"frame",
					@"hasAmbiguousLayout",
					@"hidden",
					@"horizontalAffectingConstraints",
					@"lastBaselineOffsetFromBottom",
					@"layoutMargins",
					@"verticalAffectingConstraints",
					@"dbgRenderingModeIsMultiLayer",
					@"dbgSubviewHierarchy"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"UIView"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"layoutFrame",
					@"identifier"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"UILayoutGuide"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"dbg_holdsSymbolImage"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"UIImageView"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"axis"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"UIStackView"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			}
		],
		@"DBGHierarchyRequestIdentifier": NSUUID.UUID.UUIDString,
		@"DBGHierarchyRequestTransportCompression":
#if REMOVE_COMPRESSION
		@NO
#else
		@YES
#endif
	};
	
	NSDictionary* phase0Response = [self _executeRequestPhaseWithRequest:phase0Dictionary hub:sharedHub outputURL:requestResponses phaseCount:0 error:error];
	RETURN_NO_IF_NIL(phase0Response);
	
	NSArray* objects = LNExtractPhoneOSPhase0ForPhase1ResponseObjects(phase0Response);
	RETURN_NO_IF_NIL(objects);
	
	NSDictionary* phase1Dictionary = @{
		@"DBGHierarchyRequestName": @"Fetch encoded layers",
		@"DBGHierarchyRequestInitiatorVersionKey": @4,
		@"DBGHierarchyRequestPriority": @0,
		@"DBGHierarchyObjectDiscovery": @2,
		@"DBGHierarchyRequestActions": @[
			@{
				@"objectIdentifiers": objects,
				@"options": @0,
				@"propertyNames": @[
					@"encodedPresentationLayer"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": NSNull.null,
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			}
		],
		@"DBGHierarchyRequestIdentifier": NSUUID.UUID.UUIDString,
		@"DBGHierarchyRequestTransportCompression":
#if REMOVE_COMPRESSION
		@NO
#else
		@YES
#endif
	};
	
	RETURN_NO_IF_NIL([self _executeRequestPhaseWithRequest:phase1Dictionary hub:sharedHub outputURL:requestResponses phaseCount:1 error:error]);
	
	objects = LNExtractPhoneOSPhase0ForPhase2ResponseObjects(phase0Response);
	RETURN_NO_IF_NIL(objects);
	
	NSDictionary* phase2Dictionary = @{
		@"DBGHierarchyRequestName": @"Fetch rendered effect view snapshots",
		@"DBGHierarchyRequestInitiatorVersionKey": @4,
		@"DBGHierarchyRequestPriority": @0,
		@"DBGHierarchyObjectDiscovery": @2,
		@"DBGHierarchyRequestActions": @[
			@{
				@"objectIdentifiers": objects,
				@"options": @0,
				@"propertyNames": @[
					@"snapshotImageRenderedUsingDrawHierarchyInRect"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": NSNull.null,
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"actionClass": @"DebugHierarchyRunLoopAction"
			}
		],
		@"DBGHierarchyRequestIdentifier": NSUUID.UUID.UUIDString,
		@"DBGHierarchyRequestTransportCompression":
#if REMOVE_COMPRESSION
		@NO
#else
		@YES
#endif
	};
	
	RETURN_NO_IF_NIL([self _executeRequestPhaseWithRequest:phase2Dictionary hub:sharedHub outputURL:requestResponses phaseCount:2 error:error]);
	
	objects = LNExtractPhoneOSPhase0ForPhase3ResponseObjects(phase0Response);
	RETURN_NO_IF_NIL(objects);
	
	NSDictionary* phase3Dictionary = @{
		@"DBGHierarchyRequestName": @"Fetch rendered view snapshots",
		@"DBGHierarchyRequestInitiatorVersionKey": @4,
		@"DBGHierarchyRequestPriority": @0,
		@"DBGHierarchyObjectDiscovery": @2,
		@"DBGHierarchyRequestActions": @[
			@{
				@"objectIdentifiers": objects,
				@"options": @0,
				@"propertyNames": @[
					@"snapshotImage"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": NSNull.null,
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			}
		],
		@"DBGHierarchyRequestIdentifier": NSUUID.UUID.UUIDString,
		@"DBGHierarchyRequestTransportCompression":
#if REMOVE_COMPRESSION
		@NO
#else
		@YES
#endif
	};
	
	RETURN_NO_IF_NIL([self _executeRequestPhaseWithRequest:phase3Dictionary hub:sharedHub outputURL:requestResponses phaseCount:3 error:error]);
	
	NSDictionary* phase4Dictionary = @{
		@"DBGHierarchyRequestName": @"Fetch remaining lazy properties",
		@"DBGHierarchyRequestInitiatorVersionKey": @4,
		@"DBGHierarchyRequestPriority": @0,
		@"DBGHierarchyObjectDiscovery": @2,
		@"DBGHierarchyRequestActions": @[
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"encodedPresentationLayer",
					@"encodedPresentationScene",
					@"dbgFormattedDisplayName",
					@"snapshotImage",
					@"snapshotImageRenderedUsingDrawHierarchyInRect",
					@"visualRepresentation",
					@"dbgSubviewHierarchy"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": NSNull.null,
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @YES
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"encodedPresentationLayer",
					@"encodedPresentationScene",
					@"dbgFormattedDisplayName",
					@"snapshotImage",
					@"snapshotImageRenderedUsingDrawHierarchyInRect",
					@"visualRepresentation",
					@"dbgSubviewHierarchy"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": NSNull.null,
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyActionLegacyV1",
				@"propertyNamesAreExclusive": @YES
			}
		],
		@"DBGHierarchyRequestIdentifier": NSUUID.UUID.UUIDString,
		@"DBGHierarchyRequestTransportCompression":
#if REMOVE_COMPRESSION
		@NO
#else
		@YES
#endif
	};
	
	RETURN_NO_IF_NIL([self _executeRequestPhaseWithRequest:phase4Dictionary hub:sharedHub outputURL:requestResponses phaseCount:4 error:error]);
	
	NSDictionary* cleanupPhaseDictionary = @{
		@"DBGHierarchyRequestName": @"Cleanup",
		@"DBGHierarchyRequestInitiatorVersionKey": @4,
		@"DBGHierarchyRequestPriority": @0,
		@"DBGHierarchyObjectDiscovery": @0,
		@"DBGHierarchyRequestActions": @[
			@{
				@"actionClass": @"DebugHierarchyResetAction"
			}
		],
		@"DBGHierarchyRequestIdentifier": NSUUID.UUID.UUIDString,
		@"DBGHierarchyRequestTransportCompression": @NO
	};
	
	RETURN_NO_IF_NIL([self _executeRequestPhaseWithRequest:cleanupPhaseDictionary hub:sharedHub outputURL:requestResponses phaseCount:-1 error:error]);
	
	NSDictionary* metadata = @{
		@"DocumentVersion": @"1",
		@"RunnableDisplayName": [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleName"],
		@"RunnablePID": @(NSProcessInfo.processInfo.processIdentifier)
	};
	
	NSData* data = [NSPropertyListSerialization dataWithPropertyList:metadata format:NSPropertyListXMLFormat_v1_0 options:0 error:error];
	RETURN_NO_IF_NIL(data);
	RETURN_NO_IF_FALSE([data writeToURL:[outputURL URLByAppendingPathComponent:@"metadata"] options:NSDataWritingAtomic error:error]);
	
	return YES;
}

@end

#endif
