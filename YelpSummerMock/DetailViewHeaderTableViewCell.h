//
//  DetailViewHeaderTableViewCell.h
//  YelpSummerMock
//
//  Created by wengyuankai on 9/5/17.
//  Copyright © 2017 wengyuankai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpDataModel.h"

@interface DetailViewHeaderTableViewCell : UITableViewCell

- (void)updateBasedOnDataModel:(YelpDataModel *)dataModel;

@end
