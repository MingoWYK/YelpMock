//
//  FilterTableViewCell.h
//  YelpSummerMock
//
//  Created by wengyuankai on 9/12/17.
//  Copyright © 2017 wengyuankai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpFilterDataModel.h"

@interface FilterTableViewCell : UITableViewCell

- (void)updateDataModel:(YelpFilterDataModel *)dataModel;

@end

