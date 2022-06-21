//
//  HYSpringboardIcon.h
//  HYSpringboardView
//
//  Created by 艾信超 on 2022/6/20.
//

#import <UIKit/UIKit.h>

@interface HYSpringboardItem : NSObject

//标识符
@property (nonatomic, strong) NSString *identifier;
//icon
@property (nonatomic, strong) NSString *iconPath;
//icon背景
@property (nonatomic, strong) NSString *iconBackgroundPath;
//icontitle
@property (nonatomic, strong) NSString *titleText;

@end

@interface HYSpringboardIcon : UIControl

//是否能删除
@property (nonatomic, assign) BOOL canBeDeleted;
//是否能拖动
@property (nonatomic, assign) BOOL canBeDragged;
//是否能点击
@property (nonatomic, assign) BOOL canBeTapped;
//是否隐藏删除image
@property (nonatomic, assign) BOOL hideDeleteImage;
//标识符
@property (nonatomic, strong) NSString *identifier;
//原位置
@property (nonatomic, strong) NSIndexPath *originIndexPath;
//icon图片、icon背景图片、icon title等
@property (nonatomic, strong) HYSpringboardItem *springboardItem;

- (BOOL)hitCloseButton:(CGPoint)point;

- (instancetype)initWithSpringboardItem:(HYSpringboardItem *)springboardItem;

@end
