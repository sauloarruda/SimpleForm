//
//  SexoViewController.m
//  Form
//
//  Created by Saulo Arruda on 9/20/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "SexoViewController.h"

@interface SexoViewController ()

@end

@implementation SexoViewController

@synthesize cliente;

- (void)viewDidAppear:(BOOL)animated
{
    for (int i=0; i<[self.tableView numberOfRowsInSection:0]; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if ([cell.textLabel.text isEqualToString:self.cliente.sexo]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            return ;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    self.cliente.sexo = cell.textLabel.text;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
