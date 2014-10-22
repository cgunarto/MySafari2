//
//  ViewController.m
//  MySafari
//
//  Created by CHRISTINA GUNARTO on 10/22/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSURL *url = [NSURL URLWithString:textField.text];  //number 4 - check later
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
}

@end
