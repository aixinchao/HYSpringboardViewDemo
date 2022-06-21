//
//  HYSpringboardCustomIcon.m
//  HYSpringboardViewDemo
//
//  Created by 艾信超 on 2022/6/20.
//

#import "HYSpringboardCustomIcon.h"

@interface HYSpringboardCustomIcon ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *appNameLabel;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation HYSpringboardCustomIcon

- (instancetype)initWithSpringboardItem:(HYSpringboardItem *)springboardItem {
    self = [super initWithSpringboardItem:springboardItem];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.iconImageView];
    [self addSubview:self.appNameLabel];
    [self addSubview:self.deleteButton];
    
//    self.backgroundColor = [UIColor colorWithRed:random() % 256 / 255.f green:random() % 256 / 255.f blue:random() % 256 / 255.f alpha:1];
    
    self.iconImageView.image = [UIImage imageNamed:self.springboardItem.iconPath];
    self.appNameLabel.text = self.springboardItem.titleText;
}

- (BOOL)hitCloseButton:(CGPoint)point {
    if (self.deleteButton.hidden) {
        return NO;
    }
    return (CGRectContainsPoint(self.deleteButton.frame, point));
}

- (void)setHideDeleteImage:(BOOL)hideDeleteImage {
    self.deleteButton.hidden = hideDeleteImage;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10.f, 60.f, 60.f)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.layer.cornerRadius = 10.f;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}

- (UILabel *)appNameLabel {
    if (!_appNameLabel) {
        _appNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 75.f, 60.f, 12.f)];
        _appNameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
        _appNameLabel.textColor = [UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:1.0];
        _appNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _appNameLabel;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.iconImageView.center.x - 30.f - 5.f, self.iconImageView.center.y - 30.f - 8.f, 25.f, 25.f)];
        _deleteButton.hidden = YES;
        _deleteButton.userInteractionEnabled = NO;
        [_deleteButton setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    }
    return _deleteButton;
}

@end
