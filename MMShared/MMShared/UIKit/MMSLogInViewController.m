//
//  MMSharedAuthActionViewController.m
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 30/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MMSLogInViewController.h"
#import "UIViewController+MMS.h"
#import "UIAlertController+MMS.h"
#import "MMSEditableTableCell.h"

@implementation MMSLogInViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    //self.usernameCell.textField
    self.passwordCell.textField.secureTextEntry = YES;
    self.passwordCell.alwaysEditable = YES;
    
    self.usernameCell.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.usernameCell.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.usernameCell.alwaysEditable = YES;
}

- (IBAction)logInButtonTapped:(id)sender{
    [self didTapLogInButton];
}

- (void)didTapLogInButton{
    self.mms_loading = YES;
    
    if([self.delegate respondsToSelector:@selector(logInViewControllerDidTapLogInButton:)]){
        [self.delegate logInViewControllerDidTapLogInButton:self];
    }
}

- (void)didError:(NSError*)error{
    self.mms_loading = NO;
    
    UIAlertController *alert = [UIAlertController mms_alertControllerWithTitle:error.localizedDescription message:error.localizedFailureReason];
    [self presentViewController:alert animated:YES completion:nil];
    
    if([self.delegate respondsToSelector:@selector(logInViewController:didError:)]){
        [self.delegate logInViewController:self didError:error];
    }
}

// Match Calendar adding events and bring the keyboard up after the view appears.
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.usernameCell.textField becomeFirstResponder];
}

- (void)didFinish{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if([self.delegate respondsToSelector:@selector(logInViewControllerDidFinish:)]){
        [self.delegate logInViewControllerDidFinish:self];
    }
}

@end
