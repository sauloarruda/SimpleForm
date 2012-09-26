//
//  ClientesViewController.m
//  Form
//
//  Created by Saulo Arruda on 9/20/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "ClientesViewController.h"
#import "ClienteFormViewController.h"
#import "Cliente.h"

@interface ClientesViewController ()

@property (nonatomic, strong) NSArray* clientesDatabase;
- (IBAction)editButtonTapped:(id)sender;

@end

@implementation ClientesViewController

#pragma mark - UIView methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editCliente"]) {
        ClienteFormViewController* destination = segue.destinationViewController;
        NSIndexPath* indexPath = self.tableView.indexPathForSelectedRow;
        Cliente* clienteSelected = [self.clientesDatabase objectAtIndex:indexPath.row];
        destination.cliente = clienteSelected;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    clientesDatabase = nil;
    [self.tableView reloadData];
}

#pragma mark - Properties override

@synthesize clientesDatabase;

- (NSArray*)clientesDatabase
{
    if (!clientesDatabase) {
        clientesDatabase = [Cliente todosClientes];
    }
    return clientesDatabase;
}

- (IBAction)editButtonTapped:(UIBarButtonItem*)sender
{
    [self.tableView setEditing:![self.tableView isEditing]];
    if ([self.tableView isEditing])
        sender.title = @"Cancelar";
    else
        sender.title = @"Editar";
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.clientesDatabase count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"clienteCell"];
    Cliente* cliente = [self.clientesDatabase objectAtIndex:indexPath.row];
    cell.textLabel.text = cliente.nome;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d anos", [cliente.idade intValue]];
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cliente* cliente = [self.clientesDatabase objectAtIndex:indexPath.row];
    [Cliente excluirCliente:cliente];
    clientesDatabase = nil; // Força recarregar do banco de dados
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    clientesDatabase = nil;
    clientesDatabase = [Cliente todosClientesByNome:searchText];
    [self.tableView reloadData];
}

@end
