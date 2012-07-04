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

#import "POActionSheet.h"
#import "POActionSheetButton.h"

@interface POActionSheet () {
    POActionSheetButton *_destructiveButton;
}
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) POActionSheetButton *destructiveButton;

@end

@implementation POActionSheet

@synthesize presentingView;
@synthesize actionSheet;
@synthesize actionSheetStyle;
@synthesize destructiveButton = _destructiveButton;

- (id) initWithTitle:(NSString*)aTitle {
    self = [super initWithTitle:aTitle];
    
    if (self) {
        self.actionSheetStyle = UIActionSheetStyleAutomatic;
    }
    
    return self;

}

- (void) addDestructiveButtonWithTitle:(NSString*) aTitle andAction:(void (^)(void))action {
    _destructiveButton = [[POActionSheetButton alloc] initWithTitle:aTitle
                                                          andAction:action];
}

- (void) show {
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:self.title
                                                             delegate:nil
                                                    cancelButtonTitle:nil 
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles: nil];
    self.actionSheet.actionSheetStyle = self.actionSheetStyle;
    for (id key in [self.buttons allKeys]) {
        [self.actionSheet addButtonWithTitle:[[self.buttons objectForKey:key] title]];
    }
    
    NSUInteger numberOfButtons = [[self.buttons allKeys] count];
    
    if (self.destructiveButton) {
        [self.actionSheet addButtonWithTitle:self.destructiveButton.title];
        self.actionSheet.destructiveButtonIndex = numberOfButtons;
    }
    
    if (self.cancelButton) {
        [self.actionSheet addButtonWithTitle:self.cancelButton.title];
        NSUInteger index = !self.destructiveButton?numberOfButtons:numberOfButtons+1;
        self.actionSheet.cancelButtonIndex = index;
    }
    
    self.actionSheet.delegate = self;
    [self.actionSheet showInView:self.presentingView.view];
}

#pragma mark - action sheet delegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == self.actionSheet.cancelButtonIndex) {
        if (self.cancelButton.action != NULL) {
            self.cancelButton.action();   
        }
    } 
    
    if (buttonIndex == self.actionSheet.destructiveButtonIndex) {
        if (self.destructiveButton.action != NULL) {
            self.destructiveButton.action();
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
