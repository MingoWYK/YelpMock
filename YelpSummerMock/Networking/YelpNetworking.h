//
//  YelpNetworking.h
//  YelpSummerMock
//
//  Created by wengyuankai on 8/26/17.
//  Copyright © 2017 wengyuankai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpDataModel.h"
#import "YelpDataStore.h"

@import CoreLocation;

typedef void (^RestaurantCompletionBlock)(NSArray <YelpDataModel *>* dataModelArray);

@interface YelpNetworking : NSObject

+ (YelpNetworking *)sharedInstance;

- (void)fetchRestaurantsBasedOnLocation:(CLLocation *)location term:(NSString *)term completionBlock:(RestaurantCompletionBlock)completionBlock;

@end
