//
//  ViewController.m
//  MySafari
//
//  Created by CHRISTINA GUNARTO on 10/22/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *webPageTitle;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.webView.scrollView.delegate = self;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSURL *url = [NSURL URLWithString:textField.text];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest: urlRequest];


    if (![textField.text containsString:@"http://"]) // checking if textfield has http:// in the beginning or not
    {
        NSString *formattedURL = [NSString stringWithFormat:@"http://%@", textField.text];
        url = [NSURL URLWithString:formattedURL];
        urlRequest = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:urlRequest];

    }

    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];

    self.webPageTitle.text = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    self.urlTextField.alpha = 0.3;
//}

-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    self.urlTextField.alpha = 0.5;
}

- (IBAction)onBackButtonPressed:(id)sender {
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }
    else
    {
        // NOTHING RIGHT NOW
    }
}

- (IBAction)onForwardButtonPressed:(id)sender
{
    if ([self.webView canGoForward])
    {
        [self.webView goForward];
    }
    else
    {
        // NOTHING RIGHT NOW
    }
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.webView stopLoading];
}

- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
}

- (IBAction)onPlusButtonPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hello!" message:@"Coming soon!!" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
//    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//    [alert addAction:okButton];

}


@end
