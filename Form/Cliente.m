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
    NSError* error;
    NSArray* clientesArray = [[ObjectManager sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error)
        NSLog(@"Ocorreu um erro ao carregar clientes: %@", error);
    return clientesArray;
}


+ (void)salvarCliente:(Cliente*)cliente
{
    [[ObjectManager sharedInstance] saveContext];
}

+ (Cliente*)new
{
    return [[ObjectManager sharedInstance] newManagedObjectForClass:[Cliente class]];
}

@end
