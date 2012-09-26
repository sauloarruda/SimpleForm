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

+ (NSArray*)todosClientes;
+ (void)salvarCliente:(Cliente*)cliente;
+ (Cliente*)new;

@end
