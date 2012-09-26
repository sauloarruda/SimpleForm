//
//  ViewController.m
//  Form
//
//  Created by Saulo Arruda on 9/20/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "ClienteFormViewController.h"
#import "SexoViewController.h"

@interface ClienteFormViewController ()
{
    BOOL _novoCliente;
}

@property (nonatomic, strong, readonly) NSArray* clientesDatabase;

@property (weak, nonatomic) IBOutlet UITextField *nomeTextField;
@property (weak, nonatomic) IBOutlet UITextField *idadeTextField;
@property (weak, nonatomic) IBOutlet UILabel *sexoLabel;


- (IBAction)doneButtonTapped:(id)sender;
- (IBAction)cancelButtonTapped:(id)sender;

@end

@implementation ClienteFormViewController

@synthesize cliente;

- (void)viewDidLoad
{
    // Não mostra o botão cancelar na edição.
    if (cliente)
        self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    // Preeche os campos da tela com os valores do model
    self.nomeTextField.text = self.cliente.nome;
    if (self.cliente.idade > 0)
        self.idadeTextField.text = [NSString stringWithFormat:@"%d", [self.cliente.idade intValue]];
    self.sexoLabel.text = self.cliente.sexo;
}

- (void)preencherClienteComDadosDaTela
{
    // Preenche o model com os valores da tela
    self.cliente.nome = self.nomeTextField.text;
    self.cliente.idade = [NSNumber numberWithInt:[self.idadeTextField.text integerValue]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self preencherClienteComDadosDaTela];
    SexoViewController* destination = segue.destinationViewController;
    destination.cliente = self.cliente;
}

- (Cliente*)cliente
{
    if (!cliente) {
        cliente = [Cliente novoCliente];
        _novoCliente = YES;
    }
    return cliente;
}

- (NSArray*)clientesDatabase
{
    return [Cliente todosClientes];
}

- (IBAction)doneButtonTapped:(id)sender {
    
    [self preencherClienteComDadosDaTela];
    [Cliente salvarClientes];
    if (self.navigationItem.leftBarButtonItem) // O botão Cancelar está visível
        // Modal
        [self dismissViewControllerAnimated:YES completion:nil];
    else
        // Push
        [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelButtonTapped:(id)sender {
    [Cliente cancelarEdicao];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
