//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.

#import "POAlertView.h"
@interface POAlertView () 
@property (nonatomic, strong) UIAlertView *alertView;
@end

@implementation POAlertView
@synthesize alertView;
@synthesize message;
@synthesize alertViewStyle;

- (id) initWithTitle:(NSString*)aTitle{
    self = [super initWithTitle:aTitle];
    
    if (self) {
        self.alertViewStyle = UIAlertViewStyleDefault;
    }
    
    return self;
    
}

- (id) initWithTitle:(NSString *)aTitle andMessage:(NSString*)aMessage {
    self = [self initWithTitle:aTitle];
    if (self) {
        self.message = aMessage;
    }
    
    return self;
}

- (void) show {
    self.alertView = [[UIAlertView alloc] initWithTitle:self.title
                                                message:self.message
                                               delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil];
    
    self.alertView.alertViewStyle = self.alertViewStyle;
    
    for (id key in [self.buttons allKeys]) {
        [self.alertView addButtonWithTitle:[[self.buttons objectForKey:key] title]];
    }
    
    NSUInteger numberOfButtons = [[self.buttons allKeys] count];
    
    
    if (self.cancelButton) {
        [self.alertView addButtonWithTitle:self.cancelButton.title];
        NSUInteger index = numberOfButtons;
        self.alertView.cancelButtonIndex = index;
    }
    
    self.alertView.delegate = self;
    [self.alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == self.alertView.cancelButtonIndex) {
        if (self.cancelButton.action != NULL) {
            self.cancelButton.action();   
        }
    } 
    
    NSArray *buttonsKeys = [self.buttons allKeys];
    if (buttonIndex < [buttonsKeys count]) {
        id key = [buttonsKeys objectAtIndex:buttonIndex];
        POActionSheetButton * btn = [self.buttons objectForKey:key];
        if (btn.action != NULL) {
            btn.action();
        }
    }

    
}


@end
