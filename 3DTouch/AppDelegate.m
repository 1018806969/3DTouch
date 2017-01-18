//
//  AppDelegate.m
//  3DTouch
//
//  Created by txx on 17/1/17.
//  Copyright © 2017年 txx. All rights reserved.
//

#import "AppDelegate.h"
#import "ShareViewController.h"
#import "SearchViewController.h"

@interface AppDelegate ()

@end

static NSString *const tShareType = @"com.51jk.DTouch.share";
static NSString *const tSearchType = @"com.51jk.DTouch.search";

@implementation AppDelegate


/**
 方法的调用：当app在后台时进入应用不调用，当app被杀死后进入应用会调用此方法
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self createShortcutItem:application];
    
    return YES;
}



/**
 点击icon快捷选项Item时的逻辑处理
 
 @param application application
 @param shortcutItem 当前选中的Item
 @param completionHandler 回调处理
 */
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController ;
    
    if ([shortcutItem.type isEqualToString:tShareType]) {
        //点击了分享
        [nav pushViewController:[ShareViewController new] animated:YES];
    }else if ([shortcutItem.type isEqualToString:tSearchType])
    {
        [nav pushViewController:[SearchViewController new] animated:YES];
    }
    
    if (completionHandler) {
        completionHandler(YES);
    }
}








































/**
 创建icon上的3D touch快捷选项
 */
-(void)createShortcutItem:(UIApplication *)application
{
    //创建系统风格的icon
    UIApplicationShortcutIcon *systemIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    //创建快捷选项Item
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc]initWithType:tShareType localizedTitle:@"分享" localizedSubtitle:@"分享微信" icon:systemIcon userInfo:nil];
    
    
    //创建自定义图片的icon
    UIApplicationShortcutIcon *customIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"1.png"];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc]initWithType:tSearchType localizedTitle:@"搜索" localizedSubtitle:@"搜索啥呢" icon:customIcon userInfo:nil];


    //添加到快捷选项数组
    application.shortcutItems = @[item1,item2];
}
@end
