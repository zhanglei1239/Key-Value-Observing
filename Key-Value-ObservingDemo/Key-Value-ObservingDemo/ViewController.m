//
//  ViewController.m
//  Key-Value-ObservingDemo
//
//  Created by zhanglei on 15/10/13.
//  Copyright © 2015年 lei.zhang. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
@interface ViewController ()
{
    UILabel * label;
    Student * student;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 200, 30)];
    [btnAdd setBackgroundColor:[UIColor redColor]];
    [btnAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnAdd.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [btnAdd setTitle:@"+" forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAdd];
    
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 300, 30)];
    [label setText:@"未触发键值对观察者"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label];
    
    student = [[Student alloc] init];
    student.name = @"name";
    student.point = 0;
    
    [student addObserver:self forKeyPath:@"point" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    [student addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
}

-(void)changeNumber:(id)sender{
    student.point = student.point+1;
    student.name = [NSString stringWithFormat:@"name%ld",(long)student.point];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"name has change to %@",[student valueForKey:@"name"]);
    }
    
    if ([keyPath isEqualToString:@"point"]) {
        NSLog(@"point has change to %@",[student valueForKey:@"point"]);
    }
    
    [label setText:[NSString stringWithFormat:@"name变更为:%@----point变更为:%@",[student valueForKey:@"name"],[student valueForKey:@"point"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [student removeObserver:self forKeyPath:@"point" context:nil];
    [student removeObserver:self forKeyPath:@"name" context:nil];
}
@end
