//
//  SearchViewController.m
//  3DTouch
//
//  Created by txx on 17/1/17.
//  Copyright © 2017年 txx. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

{
    UILabel *_label;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"search page";
    self.view.backgroundColor = [UIColor orangeColor];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(100, 200, 300, 40)];
    _label.text = self.index;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor blackColor];
    _label.backgroundColor = [UIColor redColor];
    [self.view addSubview:_label];
}

//当弹出本预览时，上滑预览视图，出现预览视图中快捷选项
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    // setup a list of preview actions
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"Aciton1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton1");
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"Aciton2" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton2");
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"Aciton3" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton3");
    }];
    
    NSArray *actions = @[action1,action2,action3];
    
    // and return them (return the array of actions instead to see all items ungrouped)
    return actions;
}
//按住移动or压力值改变时的回调
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *arrayTouch = [touches allObjects];
    UITouch *touch = (UITouch *)[arrayTouch lastObject];
    
    //红色背景的label显示压力值
    _label.text = [NSString stringWithFormat:@"压力%f",touch.force];
    //红色背景的label.y＝压力值*100
    _label.frame = CGRectMake(100, touch.force * 100, 300, 40);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
