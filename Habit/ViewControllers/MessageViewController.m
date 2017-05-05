//
//  MessageViewController.m
//  Habit
//
//  Created by ZhengBob on 7/4/2017.
//  Copyright © 2017 Esquel. All rights reserved.
//

#import "MessageViewController.h"
#import "HttpRequest.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getData];
}

- (void)getData
{
    // http://getazlnx001.chinacloudapp.cn:8080/lovewall?method=open_lovewallbycompanyid&company_id=1
    
    [HttpRequest requestWithURLString:@"http://getazlnx001.chinacloudapp.cn:8080/lovewall?method=open_lovewallbycompanyid&company_id=1" parameters:nil type:HttpRequestTypeGet success:^(id responseObject) {
        NSArray *array = [NSArray array];
        NSError *error = nil;
        if (responseObject) {
            array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"array:%@", array);
            for (NSDictionary *dict in array) {
                
            }
            
        }else
        {
            NSLog(@"网络请求失败");
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
