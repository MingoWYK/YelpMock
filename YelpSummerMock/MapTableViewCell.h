//
//  MapTableViewCell.h
//  YelpSummerMock
//
//  Created by wengyuankai on 9/5/17.
//  Copyright © 2017 wengyuankai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpDataModel.h"
#import "YelpAnnotation.h"

@interface MapTableViewCell : UITableViewCell

- (void)updateBasedOnDataModel:(YelpDataModel *)dataModel;

@end
