//
//  HYSpringboardData.h
//  HYSpringboardView
//
//  Created by 艾信超 on 2022/6/20.
//

#import <Foundation/Foundation.h>
#import "HYSpringboardIcon.h"

@interface HYSpringboardData : NSObject

//最大行数
@property (nonatomic, assign) NSInteger maxRows;
//最大列数
@property (nonatomic, assign) NSInteger maxColumns;
//标识符
@property (nonatomic, strong) NSString *persistKey;
//iconPages数组
@property (nonatomic, strong) NSMutableArray *springboardIconPages;

//添加icon
- (void)addIcon:(HYSpringboardIcon *)icon;

//添加icon在第pageIndex页第iconIndex个
- (void)addIcon:(HYSpringboardIcon *)icon pageIndex:(NSUInteger)pageIndex iconIndex:(NSUInteger)iconIndex;

//移动icon到第pageIndex页第iconIndex个
- (void)moveIcon:(HYSpringboardIcon *)icon toPage:(NSUInteger)pageIndex toIndex:(NSUInteger)iconIndex;

//移除icon
- (void)removeIcon:(HYSpringboardIcon *)icon;

//添加page
- (NSMutableArray *)addPage;

//移除空page
- (void)removeEmptyPages;

//根据identifier获取icon数组
- (NSArray *)findIconsByIdentifier:(NSString *)identifier;

//返回包含icon的page数组
- (NSMutableArray *)pageOfIcon:(HYSpringboardIcon *)icon;

//获取总的icon个数
- (NSUInteger)iconCount;

//获取总的page页数
- (NSUInteger)pageCount;

@end
