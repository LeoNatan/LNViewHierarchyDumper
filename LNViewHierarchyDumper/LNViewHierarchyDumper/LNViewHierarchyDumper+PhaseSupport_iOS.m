//
//  LNViewHierarchyDumper+PhaseSupport_iOS.m
//  
//
//  Created by Leo Natan on 02/08/2023.
//

#import "LNViewHierarchyDumper-Private.h"
#import "LNViewHierarchyDumper+PhaseSupport_iOS.h"

#if TARGET_OS_IPHONE || TARGET_OS_MACCATALYST

NSArray<NSString*>* LNExtractPhoneOSPhase0ForPhase1ResponseObjects(NSDictionary* phase1Response)
{
	NSArray<NSDictionary*>* topLevelGroupsCALayers	= phase1Response[@"topLevelGroups"][@"com.apple.QuartzCore.CALayer"][@"debugHierarchyObjects"];
	
	return [topLevelGroupsCALayers valueForKey:@"objectID"];
}

/*
NSArray<NSString*>* LNExtractPhoneOSPhase0ForPhase2ResponseObjects(NSDictionary* phase1Response)
{
	NSArray<NSDictionary*>* topLevelGroupsCALayers	= phase1Response[@"topLevelGroups"][@"com.apple.QuartzCore.CALayer"][@"debugHierarchyObjects"];
	
	return [topLevelGroupsCALayers valueForKey:@"objectID"];
}

NSArray<NSString*>* LNExtractPhoneOSPhase0ForPhase3ResponseObjects(NSDictionary* phase1Response)
{
	NSArray<NSDictionary*>* topLevelGroupsCALayers	= phase1Response[@"topLevelGroups"][@"com.apple.QuartzCore.CALayer"][@"debugHierarchyObjects"];
	
	return [topLevelGroupsCALayers valueForKey:@"objectID"];
}
 */

@implementation LNViewHierarchyDumper (PhaseSupport_iOS)

- (BOOL)_startPhasesWithHub:(id /*DebugHierarchyTargetHub*/)sharedHub outputURL:(NSURL*)outputURL error:(NSError**)error
{
	NSURL* requestResponses = [outputURL URLByAppendingPathComponent:@"RequestResponses" isDirectory:YES];
	RETURN_NO_IF_FALSE([NSFileManager.defaultManager createDirectoryAtURL:requestResponses withIntermediateDirectories:YES attributes:nil error:error]);
	
	NSDictionary* phase0Dictionary = @{
		@"DBGHierarchyRequestName": @"Initial request",
		@"DBGHierarchyRequestInitiatorVersionKey": @3,
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
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": NSNull.null,
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
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
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"CALayer"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
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
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"NSLayoutConstraint"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
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
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"SKNode"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"scaleMode",
					@"size"
				],
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"SKScene"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @1,
				@"propertyNames": NSNull.null,
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @3,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"SKView"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyActionLegacyV1",
				@"propertyNamesAreExclusive": @0
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @1,
				@"propertyNames": NSNull.null,
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @3,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"SKScene"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyActionLegacyV1",
				@"propertyNamesAreExclusive": @0
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @1,
				@"propertyNames": NSNull.null,
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @3,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"SKNode"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyActionLegacyV1",
				@"propertyNamesAreExclusive": @0
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
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"UIScreen"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"keyWindow",
					@"statusBarOrientation"
				],
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"UIApplication"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"title",
					@"activationState"
				],
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"UIScene"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"title",
					@"internal",
					@"visible"
				],
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"UIWindow"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"title"
				],
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"UIViewController"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
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
					@"dbgSubviewHierarchy"
				],
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"UIView"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"layoutFrame",
					@"identifier"
				],
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"UILayoutGuide"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"dbg_holdsSymbolImage"
				],
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"UIImageView"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"axis"
				],
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": @[
					@"UIStackView"
				],
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
			}
		],
		@"DBGHierarchyRequestIdentifier": NSUUID.UUID.UUIDString,
		@"DBGHierarchyRequestTransportCompression": @YES
	};
	
	NSDictionary* phase0Response = [self _executeRequestPhaseWithRequest:phase0Dictionary hub:sharedHub outputURL:requestResponses phaseCount:0 error:error];
	RETURN_NO_IF_NIL(phase0Response);
	
	NSArray* objects = LNExtractPhoneOSPhase0ForPhase1ResponseObjects(phase0Response);
	RETURN_NO_IF_NIL(objects);
	
	NSDictionary* phase1Dictionary = @{
		@"DBGHierarchyRequestName": @"Fetch encoded layers",
		@"DBGHierarchyRequestInitiatorVersionKey": @3,
		@"DBGHierarchyRequestPriority": @0,
		@"DBGHierarchyObjectDiscovery": @2,
		@"DBGHierarchyRequestActions": @[
			@{
				@"objectIdentifiers": objects,
				@"options": @0,
				@"propertyNames": @[
					@"encodedPresentationLayer"
				],
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": NSNull.null,
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @0
			}
		],
		@"DBGHierarchyRequestIdentifier": NSUUID.UUID.UUIDString,
		@"DBGHierarchyRequestTransportCompression": @YES
	};
	
	RETURN_NO_IF_NIL([self _executeRequestPhaseWithRequest:phase1Dictionary hub:sharedHub outputURL:requestResponses phaseCount:1 error:error]);
	
	NSDictionary* phase2Dictionary = @{
		@"DBGHierarchyRequestName": @"Fetch remaining lazy properties",
		@"DBGHierarchyRequestInitiatorVersionKey": @3,
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
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": NSNull.null,
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @1
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
				@"exactTypesAreExclusive": @0,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @0,
				@"visibility": @15,
				@"types": NSNull.null,
				@"objectIdentifiersAreExclusive": @0,
				@"actionClass": @"DebugHierarchyPropertyActionLegacyV1",
				@"propertyNamesAreExclusive": @1
			}
		],
		@"DBGHierarchyRequestIdentifier": NSUUID.UUID.UUIDString,
		@"DBGHierarchyRequestTransportCompression": @YES
	};
	
	RETURN_NO_IF_NIL([self _executeRequestPhaseWithRequest:phase2Dictionary hub:sharedHub outputURL:requestResponses phaseCount:2 error:error]);
	
	NSDictionary* cleanupPhaseDictionary = @{
		@"DBGHierarchyRequestName": @"Cleanup",
		@"DBGHierarchyRequestInitiatorVersionKey": @3,
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
