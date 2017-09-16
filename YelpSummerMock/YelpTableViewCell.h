//
//  YelpTableViewCell.h
//  YelpSummerMock
//
//  Created by wengyuankai on 8/29/17.
//  Copyright © 2017 wengyuankai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YelpDataModel.h"

@interface YelpTableViewCell : UITableViewCell

- (void)updateBasedOnDataModel:(YelpDataModel *)dataModel;

@end
