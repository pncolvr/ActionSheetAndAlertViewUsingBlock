## Synopsys


The purpose of this project is to provide a simpler API to UIAlertView and UIActionSheet. This code abstracts the need for delegates and allows the programmer to program the action for each button while creating the view, UIAlertView or UIActionSheet.

##Example

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

##License

Apache License, Version 2.0 ([http://www.apache.org/licenses/LICENSE-2.0.html](http://www.apache.org/licenses/LICENSE-2.0.html))

#Author

Pedro Oliveira ([@pncolvr](http://twitter.com/pncolvr))


