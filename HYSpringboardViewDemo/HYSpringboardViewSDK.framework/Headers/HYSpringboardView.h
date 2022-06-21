//
//  HYSpringboardView.h
//  HYSpringboardViewSDK
//
//  Created by 艾信超 on 2022/6/20.
//

#import <UIKit/UIKit.h>
#import "HYSpringboardViewDelegate.h"
#import "HYSpringboardViewDataSource.h"

typedef NS_ENUM(NSInteger, HYSpringboardViewIconLayoutType) {
    HYSpringboardViewIconLayoutTypeLeft = 0,
    HYSpringboardViewIconLayoutTypeSideLeft,
    HYSpringboardViewIconLayoutTypeCenter
};

@interface HYSpringboardView : UIView

//dataSource代理
@property (nonatomic, weak) id <HYSpringboardViewDataSource> dataSource;
//delegate代理
@property (nonatomic, weak) id <HYSpringboardViewDelegate> delegate;
//标识符
@property (nonatomic, strong) NSString *persistKey;
//keyView
@property (nonatomic, strong) UIView *keyView;
//编辑状态
@property (nonatomic, readonly) BOOL editing;
//最大限制
@property (nonatomic, assign) BOOL enableMaxLimit;
//icon布局
@property (nonatomic, assign) HYSpringboardViewIconLayoutType iconLayoutType;

//刷新
- (void)reloadData;
//开始编辑
- (void)startEditing;
//停止编辑
- (void)stopEditing;
//设置page
- (void)setCurrentPage:(NSUInteger)currentPage animated:(BOOL)animated;
//当前page
- (NSUInteger)currentPage;
//添加icon
- (void)addIcon:(HYSpringboardIcon *)icon;
//移除icon
- (void)removeIcon:(HYSpringboardIcon *)icon;
//移除icon
- (void)removeIconAnimated:(HYSpringboardIcon *)icon completion:(void(^)(void))block;

@end
