//
//  LNViewHierarchyDumper+PhaseSupport_macOS.m
//  
//
//  Created by Leo Natan on 02/08/2023.
//

#import "LNViewHierarchyDumper-Private.h"
#import "LNViewHierarchyDumper+PhaseSupport_macOS.h"

#if TARGET_OS_OSX

NSArray<NSString*>* LNExtractPhase0ForPhase1ResponseObjects(NSDictionary* phase1Response)
{
	NSArray<NSDictionary*>* topLevelGroupsCALayers	= phase1Response[@"topLevelGroups"][@"com.apple.QuartzCore.CALayer"][@"debugHierarchyObjects"];
	
	return [topLevelGroupsCALayers valueForKey:@"objectID"];
}


@implementation LNViewHierarchyDumper (PhaseSupport_macOS)

- (BOOL)_startPhasesWithHub:(id /*DebugHierarchyTargetHub*/)sharedHub outputURL:(NSURL*)outputURL error:(NSError**)error
{
	NSURL* requestResponses = [outputURL URLByAppendingPathComponent:@"RequestResponses" isDirectory:YES];
	RETURN_NO_IF_FALSE([NSFileManager.defaultManager createDirectoryAtURL:requestResponses withIntermediateDirectories:YES attributes:nil error:error]);
	
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
					@"keyWindow",
					@"mainWindow"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"NSApplication"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"frame",
					@"title",
					@"visible",
					@"attachedSheet",
					@"backingScaleFactor"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"NSWindow"
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
					@"NSViewController"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"bounds",
					@"firstBaselineOffsetFromTop",
					@"flipped",
					@"frame",
					@"hidden",
					@"lastBaselineOffsetFromBottom",
					@"visibleRect",
					@"wantsDefaultClipping",
					@"ambiguityStatusMask",
					@"frameAlignmentRect",
					@"hasAmbiguousLayout",
					@"horizontalAffectingConstraints",
					@"verticalAffectingConstraints",
					@"dbgSubviewHierarchy"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"NSView"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"orientation"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"NSStackView"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			},
			@{
				@"objectIdentifiers": NSNull.null,
				@"options": @0,
				@"propertyNames": @[
					@"frame",
					@"identifier"
				],
				@"exactTypesAreExclusive": @NO,
				@"optionsComparisonStyle": @0,
				@"exactTypes": NSNull.null,
				@"typesAreExclusive": @NO,
				@"visibility": @15,
				@"types": @[
					@"NSLayoutGuide"
				],
				@"objectIdentifiersAreExclusive": @NO,
				@"actionClass": @"DebugHierarchyPropertyAction",
				@"propertyNamesAreExclusive": @NO
			}
		],
		@"DBGHierarchyRequestIdentifier": NSUUID.UUID.UUIDString,
		@"DBGHierarchyRequestTransportCompression": @NO
	};
	
	NSDictionary* phase0Response = [self _executeRequestPhaseWithRequest:phase0Dictionary hub:sharedHub outputURL:requestResponses phaseCount:0 error:error];
	RETURN_NO_IF_NIL(phase0Response);
	
	NSArray* objects = LNExtractPhase0ForPhase1ResponseObjects(phase0Response);
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
		@"DBGHierarchyRequestTransportCompression": @NO
	};
	
	RETURN_NO_IF_NIL([self _executeRequestPhaseWithRequest:phase1Dictionary hub:sharedHub outputURL:requestResponses phaseCount:1 error:error]);
	
	NSDictionary* phase2Dictionary = @{
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
		@"DBGHierarchyRequestTransportCompression": @NO
	};
	
	RETURN_NO_IF_NIL([self _executeRequestPhaseWithRequest:phase2Dictionary hub:sharedHub outputURL:requestResponses phaseCount:2 error:error]);
	
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
