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
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadURL:@"http://www.mobilemakers.co"];

    //setting this VC as the delegate of webView scrollview
    self.webView.scrollView.delegate = self;

    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = size;


}

// method for loadingURL to decrease repetition
- (void) loadURL: (NSString *) loadURL
{
    NSURL *url = [NSURL URLWithString:loadURL];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestURL];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self loadURL:textField.text];


    // checking if textfield has http:// in the beginning or not
    // if textfield.text string doesn't contain @"http://" then add it to the beginning
    if (![[textField.text lowercaseString] hasPrefix:@"http://"])

    {
        NSString *formattedURL = [NSString stringWithFormat:@"http://%@", textField.text];
        [self loadURL:formattedURL];

    }

    //get rid of keyboard when text field is entered
    [textField resignFirstResponder];
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];

    //making sure that the fwd and backward buttons are disabled when there are no corresponding web views
    self.backButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;


    //extracting the webpage document title and setting it to Nav Bar Controller into WebPage Title's text
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    //ADD a command that sets the URL title into the page's current title

}

//Alternative code 
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//
//    CGFloat totalScroll = self.webView.frame.size.height - self.webView.bounds.size.height;
//
//    /* This is the current offset. */
//    CGFloat offset = scrollView.contentOffset.y;
//
//    /* This is the percentage of the current offset / bottom offset. */
//    CGFloat percentage = offset / totalScroll;
//
//    /* When percentage = 0, the alpha should be 1 so we should flip the percentage. */
//    self.urlTextField.alpha = (1.f - percentage);
//
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 30)
    {
        [UIView animateWithDuration:.2 animations:^
        {
            self.urlTextField.alpha = 0.5;
            self.urlTextField.frame = CGRectMake(self.urlTextField.frame.origin.x,70, self.urlTextField.frame.size.width, self.urlTextField.frame.size.height);}];
    }
    else
    {
        [UIView animateWithDuration:.2 animations:^
        {
            self.urlTextField.alpha = 0.5;
            self.urlTextField.frame = CGRectMake(self.urlTextField.frame.origin.x, -30, self.urlTextField.frame.size.width, self.urlTextField.frame.size.height);}];
        }
}


- (IBAction)onBackButtonPressed:(id)sender
{
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
        // set the URL as blank when button goes back
        self.urlTextField.text = nil;
    }
}

- (IBAction)onForwardButtonPressed:(id)sender
{
    if ([self.webView canGoForward])
    {
        [self.webView goForward];
        // set the URL as blank when button goes forward
        self.urlTextField.text = nil;
    }
}

- (IBAction)onStopLoadingButtonPressed:(id)sender
{
    [self.webView stopLoading];
}

- (IBAction)onReloadButtonPressed:(id)sender
{
    [self.webView reload];
}

- (IBAction)onPlusButtonPressed:(id)sender
{
    // create an alert with OK button when plus (thumbs up) button is pressed
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hello!" message:@"Coming soon!!" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okButton];

}


@end
