//
//  ViewController.m
//  DreamCatcherApp
//
//  Created by James Rochabrun on 08-03-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *titles;

@property NSMutableArray *descriptions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //allocation and init sapce in memory for the titles NSmutablearray
    self.titles = [NSMutableArray new];
    
    //allocation and init in space for the description Nsmutable array is the same like new, but we use  it if want to make a custom init, or just bee more explicit
    self.descriptions = [[NSMutableArray alloc]init];
    
}

-(void)presentDreamEntry{
    
    //here is the prompt window
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter new dream" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    //now adding a text field for the title
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Dream Title";
    }];
    
    //adding a new text field for the description
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Dream description";
    }];
    
    
    //cancel action
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    //save action
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //a) new instance of the textfield added to the alertController object porperties textFields firstObject
        UITextField *textField1 = alertController.textFields.firstObject;
        
        //b) adding the item in to the NSMutable array using the addobject method, textField.text is the text that the user put.
        [self.titles addObject:textField1.text];
        
        //adding the description to the NSMutable array combinig a and b steps in one line. also here we specify lastobject because is the last text field of the alertController
        
        [self.descriptions addObject:alertController.textFields.lastObject.text];
        
        //finally we reolad the data of the tableView
        [self.tableView reloadData];
    }];
    
    //now lets add the actions to the alertController
    
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    
    //finally we use the presentViewCiontroller method to present the alertController to the viewController "(self)"
      //the completion field is used if we want something after the viewController is present
    [self presentViewController:alertController animated:true completion:nil];
    
     
}



//decides what to display in the cell
//the method here is tableView:cellForRowAtIndexPath:

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    //setting the title text for the cell
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    
    //setting the description text for the cell
    
    cell.detailTextLabel.text = [self.descriptions objectAtIndex:indexPath.row];
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //numbers of objects inside the array
    return self.titles.count;
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
   
    //toggling the appearance of the edit button .editing is a property of type BOOL of the ViewController class
    
    if (self.editing) {
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    } else{
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
        
    }
    
}


//adding a delegate method tableView:canMoveRowAtindexPath: and return true

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

//also need to add the delegate method tableView:moveRowAtIndexPath:toIndexPath:

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    
    //we use the sourceIndexPath parameter to asign a title in the array
    NSString *title = [self.titles objectAtIndex:sourceIndexPath.row];
    //we use the title local variable to remove it form the array
    [self.titles removeObject:title];
    //we use the same variable and the destinationIndexPath parameter to insert it in the array
    [self.titles insertObject:title  atIndex:destinationIndexPath.row];
    
    //now lets repeat it for the self.descriptions aray...
    
    NSString *description = [self.descriptions objectAtIndex:sourceIndexPath.row];
    [self.descriptions removeObject:description];
    [self.descriptions insertObject:description  atIndex:destinationIndexPath.row];

}

- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {
    
    [self presentDreamEntry];
}

//adding a delete method, with the tableView:commitEditingStyle method

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //removing the title in the cell
    [self.titles removeObjectAtIndex:indexPath.row];
    
    //removing the description in the cell
    [self.descriptions removeObjectAtIndex:indexPath.row];
    
    //finally we reolad the data of the tableView
    [self.tableView reloadData];
    
}


///////////////////////////////detailViewController/////////////////////////

//method preparForSegue:sender:
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    //creating a new instance with DetailViewController class, and asign it with the segue object with the destinationViewController property
    
    DetailViewController *detailViewController = segue.destinationViewController;
    
    //this is going to give us the index row whatever row de user taps, remeber that the titleString is a property defined in the DetailViecontroller.h and its a porperty of the DetailViewController class.
    
    detailViewController.titleString = [self.titles objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    
    //doing the same for the descriptionString, what happens here with the objectAtIndex method we are selecting a row where the user taps and asign the content to the detailViewController.descriptionString and the we need to go to the DetailViewController file and in the viewDidLoad methid bind the text with this content.
    
    detailViewController.descriptionString = [self.descriptions objectAtIndex:self.tableView.indexPathForSelectedRow.row];

}





@end










