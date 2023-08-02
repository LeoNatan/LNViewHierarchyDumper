//
//  NSData+GZIP.h
//  
//
//  Created by Leo Natan on 02/08/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (GZIP)

@property (nonatomic, readonly, getter=isGzippedData) BOOL gzippedData;
@property (nonatomic, strong, readonly, nullable) NSData* gunzippedData;

@end

NS_ASSUME_NONNULL_END
