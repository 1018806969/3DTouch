//
//  ViewController.m
//  3DTouch
//
//  Created by txx on 17/1/17.
//  Copyright © 2017年 txx. All rights reserved.
//

#import "ViewController.h"
#import "SearchViewController.h"


@interface ViewController ()<UIViewControllerPreviewingDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSString *const tCellReuserId = @"cell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"first page";

    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tCellReuserId];
    
    
}

/**
 修改shortcutItem
 */
- (IBAction)alterShortcutItem:(UIButton *)sender {
    if (!_textField.text)  return;
        
    UIApplication *application = [UIApplication sharedApplication];
    
    //要修改的那个Item
    UIApplicationShortcutItem *item = application.shortcutItems[0];
    //可变复制Item
    UIMutableApplicationShortcutItem *mutableItem = [item mutableCopy];
    //修改可变Item的属性
    [mutableItem setLocalizedTitle:_textField.text];
    
    
    //可变复制Item数组
    NSMutableArray *items = [application.shortcutItems mutableCopy];
    //替换原来的Item
    [items replaceObjectAtIndex:0 withObject:mutableItem];
    
    //重置application的items
    application.shortcutItems = items;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tCellReuserId];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    
    //给cell注册3D Touch的peek和pop功能
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }else
    {
        NSLog(@"3D Touch 不可用");
    }
    return cell;
}
/**
 UIViewControllerPreviewingDelegate方法 peek预览

 @param previewingContext 预览上下文
 @param location location
 @return vc
 */
-(nullable UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    //获取按压的cell
    UITableViewCell *cell = (UITableViewCell *)[previewingContext sourceView];
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    
    //设定预览界面
    SearchViewController *searchVc = [[SearchViewController alloc]init];
    searchVc.preferredContentSize = CGSizeMake(0, 500);
    searchVc.index = [NSString stringWithFormat:@"%ld,用力按一下进来",(long)indexPath.row];
    
    //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width,44);
    previewingContext.sourceRect = rect;
    
    //返回预览界面
    return searchVc;
}
/**
 进入预览vc

 @param previewingContext 预览上下文
 @param viewControllerToCommit 进入的vc
 */
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:viewControllerToCommit sender:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
