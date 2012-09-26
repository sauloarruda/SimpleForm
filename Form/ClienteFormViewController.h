//
//  ViewController.h
//  Form
//
//  Created by Saulo Arruda on 9/20/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cliente.h"

@interface ClienteFormViewController : UITableViewController

@property (nonatomic, strong) NSArray* clientesDatabase;
@property (nonatomic, strong) Cliente* cliente;

@end
