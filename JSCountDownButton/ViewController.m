//
//  ViewController.m
//  JSCountDownButton
//
//  Created by V on 5/4/2016.
//  Copyright © 2016 V. All rights reserved.
//

#import "ViewController.h"
#import "JSCountDownButton.h"

@interface ViewController ()

@property (nonatomic, strong)JSCountDownButton *btn;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _btn = [JSCountDownButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(100, 100, 100, 100);
    _btn.backgroundColor = [UIColor blueColor];
    [_btn addTouchedHandler:^(JSCountDownButton *button) {
        
        button.enabled = NO;
        [button startWithSecond:3];
        
        [button didChanged:^NSString *(JSCountDownButton *button, NSInteger second) {
            
        
            NSString *title = [NSString stringWithFormat:@"%ld", second];
            return title;
            
        }];
        
        [button didFinished:nil];
    }];
    
    [self.view addSubview:_btn];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
