//
//  DynamicTableViewController.m
//  TableViewCellWithAutoLayoutForIos8
//
//  Created by Maksym Prokopchuk on 8/4/15.
//  Copyright (c) 2015 Maksym Prokopchuk. All rights reserved.
//

// show 3 kind of cells
// 1 - how to set minimal cell hieght
// 2 - how to avoid wrong prefred max width. Why you should directly use updateConstraints. Where you should update constainsts
// 3 - how to avoid "UIView-Encapsulated-Layout-Height"

// For each cell right and wrong implementation

#import "DynamicTableViewController.h"
#import "DynamicTableViewCell.h"

static NSString *kDynamicCellIdentifier = @"dynamicCellIdentifier";

@interface DynamicTableViewController ()

@end

@implementation DynamicTableViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS 8 Self Sizing Cells";
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clear:)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRow:)];
    
    self.tableView.allowsSelection = NO;
    
    [self.tableView registerClass:[DynamicTableViewCell class] forCellReuseIdentifier:kDynamicCellIdentifier];
    
    // Self-sizing table view cells in iOS 8 require that the rowHeight property of the table view be set to the constant UITableViewAutomaticDimension
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Self-sizing table view cells in iOS 8 are enabled when the estimatedRowHeight property of the table view is set to a non-zero value.
    // Setting the estimated row height prevents the table view from calling tableView:heightForRowAtIndexPath: for every row in the table on first load;
    // it will only be called as cells are about to scroll onscreen. This is a major performance optimization.
    self.tableView.estimatedRowHeight = 44.0; // set this to whatever your "average" cell height is; it doesn't need to be very accurate
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self p_registerContentSizeChangedNotification];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self p_unregisterContentSizeChangedNotification];
}


#pragma mark - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDynamicCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell for this indexPath
//    [cell updateFonts];

// if you have accessoryView or accessoryType than label's height calculated wrong.
// try to set prefered max width and try to increase intrinsicContentSize
    cell.bounds = CGRectMake(0.0, 0.0, CGRectGetWidth(tableView.bounds), 99999);
    cell.contentView.bounds = cell.bounds;
    [cell layoutIfNeeded];
    
    cell.labelDeliveryTitle.text = @"Способ доставки";
    cell.labelDeliveryMethod.text = @"Самовывоз из точки выдачи";
    cell.labelDeliveryDetailed.text = @"Отделение №1, ул. Комсомольская, д. 46А (ориентируйтесь на указатели СЦ \"Точка\")";
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
    
    return cell;
}


#pragma mark - Content changed
- (void)p_registerContentSizeChangedNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(p_contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)p_unregisterContentSizeChangedNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

// This method is called when the Dynamic Type user setting changes (from the system Settings app)
- (void)p_contentSizeCategoryChanged:(NSNotification *)notification {
    [self.tableView reloadData];
}

@end
