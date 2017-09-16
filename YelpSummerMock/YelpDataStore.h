//
//  YelpDataStore.h
//  YelpSummerMock
//
//  Created by wengyuankai on 9/2/17.
//  Copyright © 2017 wengyuankai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpDataModel.h"
@import CoreLocation;
@interface YelpDataStore : NSObject

@property (nonatomic, copy) NSArray <YelpDataModel *> *dataModels;
@property (nonatomic) CLLocation *userLocation;

@property (nonatomic) NSString *priceParameter;

@property (nonatomic) NSMutableSet *selectedCategories;

+ (YelpDataStore *)sharedInstance;
@end

