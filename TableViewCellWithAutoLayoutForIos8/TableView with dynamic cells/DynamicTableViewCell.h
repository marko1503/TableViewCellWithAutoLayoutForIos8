//
//  DynamicTableViewCell.h
//  TableViewCellWithAutoLayoutForIos8
//
//  Created by Maksym Prokopchuk on 8/4/15.
//  Copyright (c) 2015 Maksym Prokopchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicTableViewCell : UITableViewCell

@property (strong, nonatomic, readonly) UILabel *labelDeliveryTitle;
@property (strong, nonatomic, readonly) UILabel *labelDeliveryMethod;
@property (strong, nonatomic, readonly) UILabel *labelDeliveryDetailed;

@property (nonatomic, strong, readonly) UIView *containerView;
@property (nonatomic, assign) CGFloat containerMinHeight;

@end
