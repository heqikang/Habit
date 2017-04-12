//
//  AppDelegate.m
//  Habit
//
//  Created by ZhengBob on 7/4/2017.
//  Copyright © 2017 Esquel. All rights reserved.
//

#import "AppDelegate.h"
#import "GSCategory.h"
#import "TabBarViewController.h"
#import "HabitViewController.h"
#import "DiscoverViewController.h"
#import "MessageViewController.h"
#import "MeViewController.h"
#import "SearchNetTool.h"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *habitNav;

@property (nonatomic, strong) UINavigationController *discoverNav;

@property (nonatomic, strong) UINavigationController *messageNav;

@property (nonatomic, strong) UINavigationController *meNav;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [SearchNetTool searchNet];
    
    UITabBarController *tabVc = [self createTabBarController];
    self.window.rootViewController = tabVc;
    self.window.backgroundColor = [UIColor whiteColor];
    
    // NavigationBar 按钮背景颜色 TarBar等相关颜色设置
    [self settingColor];
    
    return YES;
}

#pragma mark -- 创建TabBarController
- (UITabBarController *)createTabBarController
{
    TabBarViewController *tabbarViewController = [[TabBarViewController alloc] init];
    
    
    // 新建空白的页面
//    HabitViewController *habitViewController = (HabitViewController *)[self viewControllerWithTitle:@"习惯" normalImage:@"ring_normal.png" selectedImage:@"ring_selected.png" class:[HabitViewController class]];
//    DiscoverViewController *discoverViewController = (DiscoverViewController *)[self viewControllerWithTitle:@"发现" normalImage:@"leaf_normal.png" selectedImage:@"leaf_selected.png" class:[DiscoverViewController class]];
//    MessageViewController *messageViewController = (MessageViewController *)[self viewControllerWithTitle:@"消息" normalImage:@"message_normal.png" selectedImage:@"message_selected.png" class:[MessageViewController class]];
//    MeViewController *meViewController = (MeViewController *)[self viewControllerWithTitle:@"我的" normalImage:@"user_normal.png" selectedImage:@"user_selected.png" class:[MeViewController class]];
    
    
    // 通过StoryBoard 创建
    HabitViewController *habitViewController = (HabitViewController *)[self viewControllerWithTitle:@"习惯" normalImage:@"ring_normal.png" selectedImage:@"ring_selected.png" storyBoardIdentify:@"habit"];
    DiscoverViewController *discoverViewController = (DiscoverViewController *)[self viewControllerWithTitle:@"发现" normalImage:@"leaf_normal.png" selectedImage:@"leaf_selected.png" storyBoardIdentify:@"discover"];
    MessageViewController *messageViewController = (MessageViewController *)[self viewControllerWithTitle:@"消息" normalImage:@"message_normal.png" selectedImage:@"message_selected.png" storyBoardIdentify:@"message"];
    MeViewController *meViewController = (MeViewController *)[self viewControllerWithTitle:@"我的" normalImage:@"user_normal.png" selectedImage:@"user_selected.png" storyBoardIdentify:@"me"];
    
    self.habitNav = [[UINavigationController alloc] initWithRootViewController:habitViewController];
    
    self.discoverNav = [[UINavigationController alloc] initWithRootViewController:discoverViewController];
    
    self.messageNav = [[UINavigationController alloc] initWithRootViewController:messageViewController];
    
    self.meNav = [[UINavigationController alloc] initWithRootViewController:meViewController];
    
    tabbarViewController.viewControllers = @[self.habitNav, self.discoverNav,  self.messageNav, self.meNav];
    
    return tabbarViewController;
}

#pragma mark -- 设置NavigationBar TarBar等相关颜色
- (void)settingColor
{
    // 设置NavigationBar的背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:86/255.0 green:180/255.0 blue:86/255.0 alpha:1]];
    
    // 设置NavigationBar标题字体大小和颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 设置NavigationBar按钮背景颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // 设置tabbar标题默认颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:86.0/255.0 green:86.0/255.0 blue:86.0/255.0 alpha:1],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    // 设置tabbar标题选中颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:86.0/255.0 green:180.0/255.0 blue:86.0/255.0 alpha:1], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
}

#pragma mark -- 设置TabBar默认状态和选中状态的图片、标题(storyBoard)
- (UIViewController *)viewControllerWithTitle:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage storyBoardIdentify:(NSString *)identify
{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc  = [main instantiateViewControllerWithIdentifier:identify];
    //设置标题
    vc.title = title;
    
    //设置普通状态图片
    UIImage *imageNormal = [UIImage imageNamed:normalImage];
    imageNormal = [imageNormal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = imageNormal;
    
    UIImage *imageSelected = [UIImage imageNamed:selectedImage];
    imageSelected = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = imageSelected;
    
    return vc;
}

#pragma mark -- 设置TabBar默认状态和选中状态的图片、标题(新建页面)
- (UIViewController *)viewControllerWithTitle:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage class:(Class)class{
    
    UIViewController *vc  = [[class alloc] init];
    //设置标题
    vc.title = title;
    
    //设置普通状态图片
    UIImage *imageNormal = [UIImage imageNamed:normalImage];
    imageNormal = [imageNormal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = imageNormal;
    
    UIImage *imageSelected = [UIImage imageNamed:selectedImage];
    imageSelected = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = imageSelected;
    
    return vc;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
