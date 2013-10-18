//
//  ViewController.m
//  SiriNumber
//
//  Created by helen on 10/17/13.
//  Copyright (c) 2013 heleny. All rights reserved.
//

#import "SiriNumberViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "SVProgressHUD.h"

@interface SiriNumberViewController ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *input;
@property (nonatomic, strong) NSString *response;

- (void)fetchNumbersAPI:(NSString*) number;

@end

@implementation SiriNumberViewController

#pragma mark - View Life Cycle

- (void)loadView
{
    [super loadView];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 200, 200, 40)];

    self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //    self.textField.borderStyle = UITextBorderStyleBezel;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.font = [UIFont boldSystemFontOfSize:25.0f];
    
    // set round border
    [self.textField.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [self.textField.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.textField.layer setBorderWidth: 1.0];
    [self.textField.layer setCornerRadius:8.0f];
    [self.textField.layer setMasksToBounds:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textField];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(onCancel:)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDone:)],
                           nil];
    
    [numberToolbar sizeToFit];
    self.textField.inputAccessoryView = numberToolbar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- selectors

- (void)onCancel:(id)sender
{
    [self.textField resignFirstResponder];
    self.textField.text = self.input;
}

- (void)onDone:(id)sender
{
    self.input = self.textField.text;
    NSLog(@"**** input: %@", self.input);
    [self.textField resignFirstResponder];
    
    // convert NSString to NSNumber
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//    NSNumber *number = [formatter numberFromString:self.input];
    
    [self fetchNumbersAPI:self.input];
}

#pragma mark - private methods

- (void)fetchNumbersAPI:(NSString *)number
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kNumbersAPIUrl, self.input]]];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (!conn) {
        NSLog(@"Error: Unable to establish a NSURLConnection");
    }
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    self.response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [SVProgressHUD showSuccessWithStatus:self.response];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:self.response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError %@", error.description);
    [SVProgressHUD showErrorWithStatus:error.description];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:error.description delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
}

@end
