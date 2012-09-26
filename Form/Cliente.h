//
//  Cliente.h
//  Form
//
//  Created by Saulo Arruda on 9/20/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Cliente : NSManagedObject

@property (nonatomic, strong) NSString* nome;
@property (nonatomic, strong) NSNumber* idade;
@property (nonatomic, strong) NSString* sexo;


// Retorna todos os clientes do banco de dados
+ (NSArray*)todosClientes;

// Retorna todos os cliente buscando pelo nome
+ (NSArray*)todosClientesByNome:(NSString*)nome;

// Grava os clientes em edição
+ (void)salvarClientes;

// Exclui um cliente específico do banco de dados
+ (void)excluirCliente:(Cliente*)cliente;

// Cancela a edição
+ (void)cancelarEdicao;

// Cria um novo cliente em branco no banco de dados
+ (Cliente*)novoCliente;

@end
