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


#import "POUserAction.h"
#import "POActionSheetButton.h"
@interface POUserAction () {
    NSMutableDictionary* _buttons;
    POActionSheetButton *_cancelButton;
    
    NSString *_title;
}

@end

@implementation POUserAction
@synthesize buttons = _buttons;
@synthesize cancelButton = _cancelButton;
@synthesize title = _title;


- (id) initWithTitle:(NSString*)aTitle {
    self = [super init];
    
    if (self) {
        _title = aTitle;
        _buttons = [[NSMutableDictionary alloc] init];
    }
    
    return self;
    
}
- (void) addButtonWithTitle:(NSString*) aTitle andAction:(void (^)(void))action {
    POActionSheetButton *btn = [[POActionSheetButton alloc] initWithTitle:aTitle
                                                                andAction:action];
    NSNumber *index = [NSNumber numberWithInt:[[self.buttons allKeys] count]];
    [self.buttons setObject:btn forKey:index];
    
}
- (void) addCancelButtonWithTitle:(NSString*) aTitle andAction:(void (^)(void))action {
    _cancelButton = [[POActionSheetButton alloc] initWithTitle:aTitle
                                                         andAction:action];
}

- (void) show {
    NSLog(@"This object does not know how to show itself, please subclass");
}

@end
