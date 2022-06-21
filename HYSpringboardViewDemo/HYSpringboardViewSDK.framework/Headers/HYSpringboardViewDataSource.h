//
//  HYSpringboardViewDataSource.h
//  HYSpringboardView
//
//  Created by 艾信超 on 2022/6/20.
//

#import <Foundation/Foundation.h>

@class HYSpringboardView;
@class HYSpringboardIcon;

NS_ASSUME_NONNULL_BEGIN

@protocol HYSpringboardViewDataSource <NSObject>

@required

//springboardView的icon的大小
- (CGSize)buttonDimensionsInSpringboardView:(HYSpringboardView *)springboardView;

//springboardView的行数
- (NSUInteger)numberOfRowsInSpringboardView:(HYSpringboardView *)springboardView;

//springboardView的列数
- (NSUInteger)numberOfColumnsInSpringboardView:(HYSpringboardView *)springboardView;

//springboardView的页面总数
- (NSUInteger)numberOfPagesInSpringboardView:(HYSpringboardView *)springboardView;

//springboardView所有的icon总数
- (NSUInteger)numberOfIconsInSpringboardView:(HYSpringboardView *)springboardView;

//springboardView的page页面icon的总数
- (NSUInteger)springboardView:(HYSpringboardView *)springboardView numberOfIconsInPage:(NSUInteger)page;

//springboardView是否包含icon
- (BOOL)springboardView:(HYSpringboardView *)springboardView contains:(HYSpringboardIcon *)icon;

//根据identifier从springboardView获取icon数组
- (NSArray *)springboardView:(HYSpringboardView *)springboardView findIconsByIdentifier:(NSString *)identifier;

//从springboardView的第pageIndex页和第iconIndex个获取HYSpringboardIcon
- (HYSpringboardIcon *)springboardView:(HYSpringboardView *)springboardView iconForPage:(NSUInteger)pageIndex atIndex:(NSUInteger)iconIndex;

//springboardView添加icon
- (void)springboardView:(HYSpringboardView *)springboardView addIcon:(HYSpringboardIcon *)icon;

//springboardView在第pageIndex页的第iconIndex个添加icon
- (void)springboardView:(HYSpringboardView *)springboardView addIcon:(HYSpringboardIcon *)icon pageIndex:(NSUInteger)pageIndex iconIndex:(NSUInteger)iconIndex;

//springboardView移动icon到第pageIndex页的第iconIndex个
- (void)springboardView:(HYSpringboardView *)springboardView moveIcon:(HYSpringboardIcon *)icon toPage:(NSUInteger)pageIndex toIndex:(NSUInteger)iconIndex;

//springboardView移除icon
- (void)springboardView:(HYSpringboardView *)springboardView removeIcon:(HYSpringboardIcon *)icon;

//添加一个新page并返回更新的page数组
- (NSMutableArray *)addPageToSpringboardView:(HYSpringboardView *)springboardView;

//删除不包含icon的空page页面
- (void)removeEmptyPages:(HYSpringboardView *)springboardView;

@end

NS_ASSUME_NONNULL_END
