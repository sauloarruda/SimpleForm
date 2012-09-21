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

@property (weak, nonatomic) IBOutlet UITextField *nomeTextField;
@property (weak, nonatomic) IBOutlet UITextField *idadeTextField;
@property (weak, nonatomic) IBOutlet UILabel *sexoLabel;

- (IBAction)doneButtonTapped:(id)sender;

@end

@implementation ClienteFormViewController

@synthesize cliente;
@synthesize clientesDatabase;

- (void)viewDidAppear:(BOOL)animated
{
    self.nomeTextField.text = self.cliente.nome;
    if (self.cliente.idade > 0)
        self.idadeTextField.text = [NSString stringWithFormat:@"%d", self.cliente.idade];
    self.sexoLabel.text = self.cliente.sexo;
}

- (void)preencherClienteComDadosDaTela
{
    self.cliente.nome = self.nomeTextField.text;
    self.cliente.idade = [self.idadeTextField.text integerValue];
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
        cliente = [[Cliente alloc] init];
        _novoCliente = YES;
    }
    return cliente;
}

- (IBAction)doneButtonTapped:(id)sender {
    
    [self preencherClienteComDadosDaTela];
    
    // Grava no array!
    if (_novoCliente)
        [self.clientesDatabase addObject:self.cliente];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
