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

#import "POViewController.h"
#import "POActionSheet.h"

@interface POViewController ()

@end

@implementation POViewController
@synthesize actionSheet;
@synthesize alertView;

@synthesize consoleTextView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setConsoleTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)didSelectShowAlertViewButton:(id)sender {
    self.alertView = [[POAlertView alloc] initWithTitle:@"Some title"];
    self.alertView.message = @"Some message";
    
    [self.alertView addCancelButtonWithTitle:@"Cancel"
                                     andAction:^(void){
                                         consoleTextView.text = [consoleTextView.text stringByAppendingString:@"Touched alert view Cancel 1\n"];
                                     }];
    
    // avoid the block retaining self, which would lead to memory leak
    __unsafe_unretained POViewController *obj = self;
    
    [self.alertView addButtonWithTitle:@"Button 1"
                               andAction:^(void){
                                   obj.consoleTextView.text = [obj.consoleTextView.text stringByAppendingString:@"Touched alert view Button 1\n"];
                               }];
    [alertView show];
}

- (IBAction)didSelectShowActionSheetButton:(id)sender {
    self.actionSheet = [[POActionSheet alloc] initWithTitle:@"Some title"];
    self.actionSheet.presentingView = self;
    
    [self.actionSheet addCancelButtonWithTitle:@"Cancel"
                                andAction:^(void){
                                    consoleTextView.text = [consoleTextView.text stringByAppendingString:@"Touched action sheet Cancel 1\n"];
                                }];
    
    // avoid the block retaining self, which would lead to memory leak
    __unsafe_unretained POViewController *obj = self;

        [self.actionSheet addButtonWithTitle:@"Button 1"
                              andAction:^(void){
                                obj.consoleTextView.text = [obj.consoleTextView.text stringByAppendingString:@"Touched action sheet Button 1\n"];
                              }];
    [actionSheet show];
}
@end
