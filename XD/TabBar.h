
#import <UIKit/UIKit.h>
#import "TabBarButton.h"
@class TabBar;
@protocol TabBarDelegate <NSObject>
@optional
- (void)tabBar:(TabBar *)tabBar didClickFrom:(NSInteger)from to:(NSInteger)to;
@end

@interface TabBar : UIView
/*!
 * 记录被选中的按钮
 */
@property (nonatomic,strong)TabBarButton * selectedBtn;
/*!
 * 指定代理指针
 */
@property(nonatomic, assign) id<TabBarDelegate> delegate;


-(void)addTabBarItemWithTitle:(NSString *)title NormalImage:(NSString *)tabBarNormal selImage:(NSString *)tabBarSel;
@end
