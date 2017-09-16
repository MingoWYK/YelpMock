//
//  YelpFilterDataModel.h
//  YelpSummerMock
//
//  Created by wengyuankai on 9/12/17.
//  Copyright © 2017 wengyuankai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpFilterDataModel : NSObject

@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *categoryCode;

+ (NSArray <YelpFilterDataModel *>*)buildDataModelArrayFromDictionaryArray:(NSArray<NSDictionary *> *)dictArray;

@end
