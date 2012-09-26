//
//  Cliente.m
//  Form
//
//  Created by Saulo Arruda on 9/20/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "Cliente.h"
#import "ObjectManager.h"

@implementation Cliente

@dynamic nome, idade, sexo;

+ (NSArray*)todosClientes
{
    NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Cliente"];
    return [[ObjectManager sharedInstance] executeFetchRequest:fetchRequest];
}

+ (NSArray*)todosClientesByNome:(NSString *)nome
{
    NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Cliente"];
    if (![@"" isEqualToString:nome]) {
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"nome CONTAINS[c] %@", nome];
        [fetchRequest setPredicate:predicate];
    }
    return [[ObjectManager sharedInstance] executeFetchRequest:fetchRequest];
}

+ (void)salvarClientes
{
    [[ObjectManager sharedInstance] saveContext];
}

+ (void)excluirCliente:(Cliente*)cliente
{
    [[ObjectManager sharedInstance].managedObjectContext deleteObject:cliente];
    [[ObjectManager sharedInstance] saveContext];
}

+ (void)cancelarEdicao
{
    [[ObjectManager sharedInstance] rollbackContext];
}

+ (Cliente*)novoCliente
{
    Cliente* cliente = [[ObjectManager sharedInstance] newManagedObjectForClass:[Cliente class]];
    cliente.idade = nil; // Limpa o valor da idade
    return cliente;
}

@end
