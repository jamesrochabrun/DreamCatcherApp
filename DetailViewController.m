//
//  DetailViewController.m
//  DreamCatcherApp
//
//  Created by James Rochabrun on 09-03-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Now setting the text for the textfield in the detailViewController object, we got this from the prepareForSegue method
    
    self.textView.text = self.descriptionString;
    
    //setting the title , title its a defined property of the DetailViewController class
    
    self.title = self.titleString;
    
    
    
}


@end
