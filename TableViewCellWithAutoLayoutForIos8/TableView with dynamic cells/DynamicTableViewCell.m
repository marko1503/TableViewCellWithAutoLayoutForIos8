//
//  DynamicTableViewCell.m
//  TableViewCellWithAutoLayoutForIos8
//
//  Created by Maksym Prokopchuk on 8/4/15.
//  Copyright (c) 2015 Maksym Prokopchuk. All rights reserved.
//

#import "DynamicTableViewCell.h"
#import "PureLayout.h"

static CGFloat const kContainerDefaultMinHeight = 44.0;

@interface DynamicTableViewCell ()

@property (strong, nonatomic, readwrite) UILabel *labelDeliveryTitle;
@property (strong, nonatomic, readwrite) UILabel *labelDeliveryMethod;
@property (strong, nonatomic, readwrite) UILabel *labelDeliveryDetailed;

@property (nonatomic, strong, readwrite) UIView *containerView;
@property (nonatomic, strong) NSLayoutConstraint *containerConstraintMinHeight;

@property (nonatomic, assign, getter = didSetupConstraints) BOOL setupConstraints;

@end

@implementation DynamicTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
//        self.contentView.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.1]; // light green
        _setupConstraints = NO;
        self.labelDeliveryTitle.backgroundColor = [UIColor redColor];
        self.labelDeliveryMethod.backgroundColor = [UIColor redColor];
        self.labelDeliveryDetailed.backgroundColor = [UIColor redColor];
//        [self updateFonts];
        
        _containerMinHeight = kContainerDefaultMinHeight;
        NSDictionary *views = @{@"containerView":self.containerView};
        NSArray *constraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|" options:0 metrics:nil views:views];
        [self.contentView addConstraints:constraintsH];
        
        NSArray *containerConstraintsVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]|" options:0 metrics:nil views:views];
        [self.contentView addConstraints:containerConstraintsVertical];
        
        self.containerConstraintMinHeight = [NSLayoutConstraint constraintWithItem:self.containerView
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:self.containerMinHeight];
        [self.contentView addConstraint:self.containerConstraintMinHeight];
        
//        [self setNeedsUpdateConstraints];
//        [self updateConstraintsIfNeeded];
        [self updateConstraints];
    }
    
    return self;
}

static CGFloat const kContentOffsetX             = 15.0;
static CGFloat const kContentOffsetY             = 7.0;
static CGFloat const kLabelTitleOffsetY          = 4.0;
static CGFloat const kLabelDeliveryMethodOffsetY = 8.0;
#pragma mark - Layout
- (void)updateConstraints {
    if (![self didSetupConstraints]) {
//        [self.labelDeliveryTitle autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(kContentOffsetY, kContentOffsetX, kContentOffsetY, kContentOffsetX)];
        
        [self.labelDeliveryTitle autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(kContentOffsetY, kContentOffsetX, kContentOffsetY, kContentOffsetX) excludingEdge:ALEdgeBottom];
        
        [self.labelDeliveryMethod autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.labelDeliveryTitle withOffset:kLabelTitleOffsetY];
        [self.labelDeliveryMethod autoConstrainAttribute:ALAttributeLeft toAttribute:ALAttributeLeft ofView:self.labelDeliveryTitle];
        [self.labelDeliveryMethod autoConstrainAttribute:ALAttributeRight toAttribute:ALAttributeRight ofView:self.labelDeliveryTitle];
        
        [self.labelDeliveryDetailed autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.labelDeliveryMethod withOffset:kLabelDeliveryMethodOffsetY];
        [self.labelDeliveryDetailed autoConstrainAttribute:ALAttributeLeft toAttribute:ALAttributeLeft ofView:self.labelDeliveryTitle];
        [self.labelDeliveryDetailed autoConstrainAttribute:ALAttributeRight toAttribute:ALAttributeRight ofView:self.labelDeliveryTitle];
        [self.labelDeliveryDetailed autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kContentOffsetY];
        
        self.setupConstraints = YES;
    }
    [super updateConstraints];
}


#pragma mark - Setters
- (void)setContainerMinHeight:(CGFloat)containerMinHeight {
    if (_containerMinHeight != containerMinHeight && containerMinHeight >= 0) {
        _containerMinHeight = containerMinHeight;
        self.containerConstraintMinHeight.constant = _containerMinHeight;
    }
}


#pragma mark - Getters
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_containerView];
    }
    return _containerView;
}

- (UILabel *)labelDeliveryTitle {
    if (!_labelDeliveryTitle) {
        _labelDeliveryTitle = [[UILabel alloc] initForAutoLayout];
        _labelDeliveryTitle.numberOfLines = 0;
        _labelDeliveryTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _labelDeliveryTitle.textColor = [UIColor blackColor];
        _labelDeliveryTitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
        _labelDeliveryTitle.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [self.containerView addSubview:_labelDeliveryTitle];
    }
    return _labelDeliveryTitle;
}

- (UILabel *)labelDeliveryMethod {
    //    return nil;
    if (!_labelDeliveryMethod) {
        _labelDeliveryMethod = [[UILabel alloc] initForAutoLayout];
        _labelDeliveryMethod.numberOfLines = 0;
        _labelDeliveryMethod.lineBreakMode = NSLineBreakByWordWrapping;
        _labelDeliveryMethod.textColor = [UIColor blackColor];
        _labelDeliveryMethod.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0];
        
        [self.containerView addSubview:_labelDeliveryMethod];
    }
    return _labelDeliveryMethod;
}

- (UILabel *)labelDeliveryDetailed {
    if (!_labelDeliveryDetailed) {
        _labelDeliveryDetailed = [[UILabel alloc] initForAutoLayout];
        _labelDeliveryDetailed.numberOfLines = 0;
        _labelDeliveryDetailed.lineBreakMode = NSLineBreakByWordWrapping;
        _labelDeliveryDetailed.textColor = [UIColor blackColor];
        _labelDeliveryDetailed.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0];
        
        [self.containerView addSubview:_labelDeliveryDetailed];
    }
    return _labelDeliveryDetailed;
}


@end
