//
//  DetailViewController.h
//  TableViewCellWithAutoLayoutForIos8
//
//  Created by Maksym Prokopchuk on 8/4/15.
//  Copyright (c) 2015 Maksym Prokopchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

