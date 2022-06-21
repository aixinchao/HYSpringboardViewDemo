//
//  ViewController.m
//  HYSpringboardViewDemo
//
//  Created by 艾信超 on 2022/6/20.
//

#import "ViewController.h"
#import <HYSpringboardViewSDK/HYSpringboardViewSDK.h>
#import "HYSpringboardCustomIcon.h"

#define HYTopLeftPersistKey     @"springBoardTopLeft"
#define HYTopRightPersistKey    @"springBoardTopRight"
#define HYBottomPersistKey      @"springBoardBottom"

@interface ViewController ()<HYSpringboardViewDelegate,HYSpringboardViewDataSource>

//背景图
@property (nonatomic, strong) UIImageView *backGImgView;
//底部毛玻璃view
@property (nonatomic, strong) UIView *bottomView;
//顶部左边springboardView
@property (nonatomic, strong) HYSpringboardView *springboardViewTopLeft;
//顶部左边数据
@property (nonatomic, strong) HYSpringboardData *springboardDataTopLeft;
//顶部右边springboardView
@property (nonatomic, strong) HYSpringboardView *springboardViewTopRight;
//顶部右边数据
@property (nonatomic, strong) HYSpringboardData *springboardDataTopRight;
//底部springboardView
@property (nonatomic, strong) HYSpringboardView *springboardViewBottom;
//底部数据
@property (nonatomic, strong) HYSpringboardData *springboardDataBottom;
//当前springboardView
@property (nonatomic, strong) HYSpringboardView *currentDraggingView;
//是否已经开始拖动
@property (nonatomic, assign) BOOL dragIconHasMoved;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self loadData];
}

- (void)setupUI {
    [self.view addSubview:self.backGImgView];
    [self.view addSubview:self.springboardViewTopLeft];
    [self.view addSubview:self.springboardViewTopRight];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.springboardViewBottom];
}

- (void)loadData {
    for (int i = 0; i < 6; i ++) {
        NSString *imagePath = @"icon_app";
        NSString *nameString = [NSString stringWithFormat:@"应用商店%d",i];
        HYSpringboardItem *springboardItem = [[HYSpringboardItem alloc] init];
        springboardItem.titleText = nameString;
        springboardItem.iconPath = imagePath;
        springboardItem.identifier = [NSString stringWithFormat:@"top_%d",i];
        HYSpringboardCustomIcon *springboardIcon = [[HYSpringboardCustomIcon alloc] initWithSpringboardItem:springboardItem];
        springboardIcon.canBeTapped = YES;
        springboardIcon.canBeDragged = YES;
        springboardIcon.canBeDeleted = YES;
        [self.springboardDataTopLeft addIcon:springboardIcon];
    }
    [self.springboardViewTopLeft reloadData];
    
    for (int i = 0; i < 9; i ++) {
        NSString *imagePath = @"icon_app";
        NSString *nameString = [NSString stringWithFormat:@"应用商店%d",i];
        HYSpringboardItem *springboardItem = [[HYSpringboardItem alloc] init];
        springboardItem.titleText = nameString;
        springboardItem.iconPath = imagePath;
        springboardItem.identifier = [NSString stringWithFormat:@"top_%d",i];
        HYSpringboardCustomIcon *springboardIcon = [[HYSpringboardCustomIcon alloc] initWithSpringboardItem:springboardItem];
        springboardIcon.canBeTapped = YES;
        springboardIcon.canBeDragged = YES;
        springboardIcon.canBeDeleted = YES;
        [self.springboardDataTopRight addIcon:springboardIcon];
    }
    [self.springboardViewTopRight reloadData];
    
    for (int i = 0; i < 3; i ++) {
        NSString *imagePath = @"icon_app";
        NSString *nameString = [NSString stringWithFormat:@"应用商店%d",i];
        HYSpringboardItem *springboardItem = [[HYSpringboardItem alloc] init];
        springboardItem.titleText = nameString;
        springboardItem.iconPath = imagePath;
        springboardItem.identifier = [NSString stringWithFormat:@"bottom_%d",i];
        HYSpringboardCustomIcon *springboardIcon = [[HYSpringboardCustomIcon alloc] initWithSpringboardItem:springboardItem];
        springboardIcon.canBeTapped = YES;
        springboardIcon.canBeDragged = YES;
        springboardIcon.canBeDeleted = YES;
        [self.springboardDataBottom addIcon:springboardIcon];
    }
    [self.springboardViewBottom reloadData];
}

- (HYSpringboardData *)springboardDataFor:(HYSpringboardView *)springboardView {
    if ([springboardView.persistKey isEqualToString:self.springboardDataTopLeft.persistKey]) {
        return self.springboardDataTopLeft;
    }
    if ([springboardView.persistKey isEqualToString:self.springboardDataTopRight.persistKey]) {
        return self.springboardDataTopRight;
    }
    if ([springboardView.persistKey isEqualToString:self.springboardDataBottom.persistKey]) {
        return self.springboardDataBottom;
    }
    return nil;
}

#pragma mark -- HYSpringboardDataSource
- (NSUInteger)numberOfRowsInSpringboardView:(HYSpringboardView *)springboardView {
    HYSpringboardData *data = [self springboardDataFor:springboardView];
    return data.maxRows;
}

- (NSUInteger)numberOfColumnsInSpringboardView:(HYSpringboardView *)springboardView {
    HYSpringboardData *data = [self springboardDataFor:springboardView];
    return data.maxColumns;
}

- (CGSize)buttonDimensionsInSpringboardView:(HYSpringboardView *)springboardView {
    return CGSizeMake(80.f, 90.f);
}

- (NSUInteger)numberOfPagesInSpringboardView:(HYSpringboardView *)springboardView {
    HYSpringboardData *data = [self springboardDataFor:springboardView];
    return [data.springboardIconPages count];
}

- (NSUInteger)numberOfIconsInSpringboardView:(HYSpringboardView *)springboardView {
    HYSpringboardData *data = [self springboardDataFor:springboardView];
    NSUInteger count = 0;
    for (NSMutableArray *page in data.springboardIconPages) {
        count += [page count];
    }
    return count;
}

- (NSUInteger)springboardView:(HYSpringboardView *)springboardView numberOfIconsInPage:(NSUInteger)page {
    HYSpringboardData *data = [self springboardDataFor:springboardView];
    if (data.springboardIconPages.count) {
        NSMutableArray *buttons = (data.springboardIconPages)[page];
        return [buttons count];
    }
    return 0;
}

- (BOOL)springboardView:(HYSpringboardView *)springboardView contains:(HYSpringboardIcon *)icon {
    HYSpringboardData *data = [self springboardDataFor:springboardView];
    if ([data pageOfIcon:icon] == nil) {
        return NO;
    }
    return YES;
}

- (HYSpringboardIcon *)springboardView:(HYSpringboardView *)springboardView iconForPage:(NSUInteger)pageIndex atIndex:(NSUInteger)iconIndex {
    HYSpringboardData *data = [self springboardDataFor:springboardView];
    NSMutableArray *buttons = (data.springboardIconPages)[pageIndex];
    return buttons[iconIndex];
}

- (void)springboardView:(HYSpringboardView *)springboardView addIcon:(HYSpringboardIcon *)icon {
    HYSpringboardData *data = [self springboardDataFor:springboardView];
    [data addIcon:icon];
}

- (void)springboardView:(HYSpringboardView *)springboardView addIcon:(HYSpringboardIcon *)icon pageIndex:(NSUInteger)pageIndex iconIndex:(NSUInteger)iconIndex {
    HYSpringboardData *data = [self springboardDataFor:springboardView];
    [data addIcon:icon pageIndex:pageIndex iconIndex:iconIndex];
}

- (void)springboardView:(HYSpringboardView *)springboardView moveIcon:(HYSpringboardIcon *)icon toPage:(NSUInteger)pageIndex toIndex:(NSUInteger)iconIndex {
    HYSpringboardData *data = [self springboardDataFor:springboardView];
    [data moveIcon:icon toPage:pageIndex toIndex:iconIndex];
}

- (void)springboardView:(HYSpringboardView *)springboardView removeIcon:(HYSpringboardIcon *)icon {
    HYSpringboardData *data = [self springboardDataFor:springboardView];
    [data removeIcon:icon];
}

- (NSMutableArray *)addPageToSpringboardView:(HYSpringboardView *)springboardView {
    HYSpringboardData *data = [self springboardDataFor:springboardView];
    return [data addPage];
}

- (void)removeEmptyPages:(HYSpringboardView *)springboardView {
    HYSpringboardData *data = [self springboardDataFor:springboardView];
    [data removeEmptyPages];
}

- (NSArray *)springboardView:(HYSpringboardView *)springboardView findIconsByIdentifier:(NSString *)identifier {
    HYSpringboardData *data = [self springboardDataFor:springboardView];
    return [data findIconsByIdentifier:identifier];
}

#pragma mark -- HYSpringboardDelegate
- (HYSpringboardView *)targetSpringboardViewForIcon:(HYSpringboardIcon *)icon {
    CGRect leftSpringboardViewRectInKeyView = [icon.superview convertRect:self.springboardViewTopLeft.frame fromView:self.springboardViewTopLeft.superview];
    CGRect rightSpringboardViewRectInKeyView = [icon.superview convertRect:self.springboardViewTopRight.frame fromView:self.springboardViewTopRight.superview];
    CGRect bottomSpringboardViewRectInKeyView = [icon.superview convertRect:self.springboardViewBottom.frame fromView:self.springboardViewBottom.superview];
    
    BOOL inLeftSpringboardView = (CGRectContainsPoint(leftSpringboardViewRectInKeyView, icon.center));
    BOOL inRightSpringBoardView = (CGRectContainsPoint(rightSpringboardViewRectInKeyView, icon.center));
    BOOL inBottomSpringBoardView = (CGRectContainsPoint(bottomSpringboardViewRectInKeyView, icon.center));\
    if ((inLeftSpringboardView && inRightSpringBoardView) || (inLeftSpringboardView && inBottomSpringBoardView) || (inRightSpringBoardView && inBottomSpringBoardView)) {
        NSLog(@"11111111");
    } else {
        if (inLeftSpringboardView) {
            return self.springboardViewTopLeft;
        }
        if (inRightSpringBoardView) {
            return self.springboardViewTopRight;
        }
        if (inBottomSpringBoardView) {
            return self.springboardViewBottom;
        }
    }
    return self.currentDraggingView;
}

- (BOOL)springboardViewShouldStopEditingAfterDraggingEnds:(HYSpringboardView *)springboardView {
    return self.dragIconHasMoved;
}

- (void)springboardView:(HYSpringboardView *)springboardView didTapSpringboardIcon:(HYSpringboardIcon *)icon {
    
}

- (void)springboardView:(HYSpringboardView *)springboardView didStartDragging:(HYSpringboardIcon *)icon {
    self.currentDraggingView = springboardView;
}

- (void)springboardView:(HYSpringboardView *)springboardView didStopDragging:(HYSpringboardIcon *)icon {
    self.currentDraggingView = nil;
}

- (void)springboardView:(HYSpringboardView *)springboardView willMoveIcon:(HYSpringboardIcon *)icon fromIndex:(NSIndexPath *)fromIndex toIndex:(NSIndexPath *)toIndex {
    self.dragIconHasMoved = YES;
}

- (void)springboardView:(HYSpringboardView *)springboardView didTapDeleteIcon:(HYSpringboardIcon *)icon {
    [springboardView.dataSource springboardView:springboardView removeIcon:icon];
    [springboardView removeIconAnimated:icon completion:^{
        [springboardView setNeedsLayout];
    }];
}

- (void)springboardView:(HYSpringboardView *)springboardView didDeleteIcon:(HYSpringboardIcon *)icon {
    
}

- (void)springboardViewDidStartEditing:(HYSpringboardView *)springboardView {
    if (!self.springboardViewTopLeft.editing) {
        [self.springboardViewTopLeft startEditing];
    }
    
    if (!self.springboardViewTopRight.editing) {
        [self.springboardViewTopRight startEditing];
    }
    
    if (!self.springboardViewBottom.editing) {
        [self.springboardViewBottom startEditing];
    }
}

- (void)springboardViewDidStopEditing:(HYSpringboardView *)springboardView {
    self.dragIconHasMoved = NO;
    if (self.springboardViewTopLeft.editing) {
        [self.springboardViewTopLeft stopEditing];
    }
    
    if (self.springboardViewTopRight.editing) {
        [self.springboardViewTopRight stopEditing];
    }
    
    if (self.springboardViewBottom.editing) {
        [self.springboardViewBottom stopEditing];
    }
}

- (HYSpringboardView *)springboardViewTopLeft {
    if (!_springboardViewTopLeft) {
        _springboardViewTopLeft = [[HYSpringboardView alloc] initWithFrame:CGRectMake(10.f, 180.f, self.view.frame.size.width / 2 - 20, 200)];
        _springboardViewTopLeft.persistKey = HYTopLeftPersistKey;
        _springboardViewTopLeft.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.25];
        _springboardViewTopLeft.layer.cornerRadius = 10;
        _springboardViewTopLeft.layer.masksToBounds = YES;
        _springboardViewTopLeft.iconLayoutType = HYSpringboardViewIconLayoutTypeSideLeft;
        _springboardViewTopLeft.delegate = self;
        _springboardViewTopLeft.dataSource = self;
    }
    return _springboardViewTopLeft;
}

- (HYSpringboardData *)springboardDataTopLeft {
    if (!_springboardDataTopLeft) {
        _springboardDataTopLeft = [[HYSpringboardData alloc] init];
        _springboardDataTopLeft.persistKey = HYTopLeftPersistKey;
        _springboardDataTopLeft.maxRows = 2;
        _springboardDataTopLeft.maxColumns = 2;
    }
    return _springboardDataTopLeft;
}

- (HYSpringboardView *)springboardViewTopRight {
    if (!_springboardViewTopRight) {
        _springboardViewTopRight = [[HYSpringboardView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 + 10, 180, self.view.frame.size.width / 2 - 20, 290)];
        _springboardViewTopRight.persistKey = HYTopRightPersistKey;
        _springboardViewTopRight.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.25];
        _springboardViewTopRight.layer.cornerRadius = 10;
        _springboardViewTopRight.layer.masksToBounds = YES;
        _springboardViewTopRight.iconLayoutType = HYSpringboardViewIconLayoutTypeSideLeft;
        _springboardViewTopRight.delegate = self;
        _springboardViewTopRight.dataSource = self;
    }
    return _springboardViewTopRight;
}

- (HYSpringboardData *)springboardDataTopRight {
    if (!_springboardDataTopRight) {
        _springboardDataTopRight = [[HYSpringboardData alloc] init];
        _springboardDataTopRight.persistKey = HYTopRightPersistKey;
        _springboardDataTopRight.maxRows = 3;
        _springboardDataTopRight.maxColumns = 2;
    }
    return _springboardDataTopRight;
}

- (HYSpringboardView *)springboardViewBottom {
    if (!_springboardViewBottom) {
        _springboardViewBottom = [[HYSpringboardView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 92.f, self.view.frame.size.width, 92.f)];
        _springboardViewBottom.persistKey = HYBottomPersistKey;
        _springboardViewBottom.enableMaxLimit = YES;
        _springboardViewBottom.iconLayoutType = HYSpringboardViewIconLayoutTypeCenter;
        _springboardViewBottom.delegate = self;
        _springboardViewBottom.dataSource = self;
    }
    return _springboardViewBottom;
}

- (HYSpringboardData *)springboardDataBottom {
    if (!_springboardDataBottom) {
        _springboardDataBottom = [[HYSpringboardData alloc] init];
        _springboardDataBottom.persistKey = HYBottomPersistKey;
        _springboardDataBottom.maxRows = 1;
        _springboardDataBottom.maxColumns = 4;
    }
    return _springboardDataBottom;
}

- (UIImageView *)backGImgView {
    if (!_backGImgView) {
        _backGImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_bg"]];
        _backGImgView.contentMode = UIViewContentModeScaleAspectFill;
        _backGImgView.frame = self.view.bounds;
    }
    return _backGImgView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 92, [[UIScreen mainScreen] bounds].size.width, 92)];
        _bottomView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.frame = _bottomView.bounds;
        effectview.alpha = 0.92;
        [_bottomView addSubview:effectview];
    }
    return _bottomView;
}

@end
