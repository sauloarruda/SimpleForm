//
//  ObjectManager.h
//  AddressBook
//
//  Created by Saulo Arruda Coelho on 7/16/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

// Altere para o nome do seu DataModel
#define kManagedObjectModelName @"ClienteModel"

// Altere para o nome que deseja criar o banco de dados SQLite
#define kPersistentStoreFilename @"Clientes.sqlite"

@interface ObjectManager : NSObject

// Acesso direto ao managedObjectContext caso necessário
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

// Instância única (singleton) de ObjectManager. NÃO use [[ObjectManager alloc] init], use [ObjectManager sharedInstance]
+ (ObjectManager*)sharedInstance;

// Cria uma instância da subclasse de NSManagedObject a partir da classe. Para usar para uma classe "Cliente" por exemplo: Cliente* cliente = [[ObjectManager sharedInstance] newManagedObjectForClass:[Cliente class]];
- (id)newManagedObjectForClass:(Class)clazz;

// Grava o contexto atual. Caso não deseje salvar use a opção rollbackContext.
- (void)saveContext;

// Cancela as alterações do contexto atual.
- (void)rollbackContext;

// Executa um FetchRequest e retorna um array. Este método trata os erros usando NSLog.
- (NSArray*)executeFetchRequest:(NSFetchRequest*)fetchRequest;

@end
