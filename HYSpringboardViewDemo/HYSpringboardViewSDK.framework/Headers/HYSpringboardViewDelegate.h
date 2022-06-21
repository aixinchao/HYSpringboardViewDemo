//
//  HYSpringboardViewDelegate.h
//  HYSpringboardView
//
//  Created by 艾信超 on 2022/6/20.
//

#import <Foundation/Foundation.h>

@class HYSpringboardView;
@class HYSpringboardIcon;

NS_ASSUME_NONNULL_BEGIN

@protocol HYSpringboardViewDelegate <NSObject>

@required

//拖动结束，返回需要嵌入icon的HYSpringboardView
- (HYSpringboardView *)targetSpringboardViewForIcon:(HYSpringboardIcon *)icon;

//icon拖动结束后springboardView是否是编辑状态
- (BOOL)springboardViewShouldStopEditingAfterDraggingEnds:(HYSpringboardView *)springboardView;

@optional

//springboardView的icon开始拖动
- (void)springboardView:(HYSpringboardView *)springboardView didStartDragging:(HYSpringboardIcon *)icon;

//springboardView的icon结束拖动
- (void)springboardView:(HYSpringboardView *)springboardView didStopDragging:(HYSpringboardIcon *)icon;

//springboardView的icon被点击
- (void)springboardView:(HYSpringboardView *)springboardView didTapSpringboardIcon:(HYSpringboardIcon *)icon;

//springboardView将要添加icon
- (void)springboardView:(HYSpringboardView *)springboardView willAddIcon:(HYSpringboardIcon *)icon;

//springboardView点击删除icon
- (void)springboardView:(HYSpringboardView *)springboardView didTapDeleteIcon:(HYSpringboardIcon *)icon;

//springboardView删除icon
- (void)springboardView:(HYSpringboardView *)springboardView didDeleteIcon:(HYSpringboardIcon *)icon;


//springboardView的icon将要从fromIndex移动到toIndex
- (void)springboardView:(HYSpringboardView *)springboardView willMoveIcon:(HYSpringboardIcon *)icon fromIndex:(NSIndexPath *)fromIndex toIndex:(NSIndexPath *)toIndex;

//springboardView开始编辑
- (void)springboardViewDidStartEditing:(HYSpringboardView *)springboardView;

//springboardView结束编辑
- (void)springboardViewDidStopEditing:(HYSpringboardView *)springboardView;

@end

NS_ASSUME_NONNULL_END
