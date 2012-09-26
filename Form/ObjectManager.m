//
//  ObjectManager.m
//  AddressBook
//
//  Created by Saulo Arruda Coelho on 7/16/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "ObjectManager.h"

static ObjectManager* __sharedInstance;

@interface ObjectManager ()

// Instância do managedObjectModel usando lazy initialization
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

// Instância do persistenceStoreCoordinator usando lazy initialization
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// Retorna a URL para o diretório "Documents" do sandbox da aplicação
- (NSURL *)applicationDocumentsDirectory;

@end

@implementation ObjectManager

#pragma mark - Métodos públicos

+ (ObjectManager*)sharedInstance
{
    if (!__sharedInstance) __sharedInstance = [[ObjectManager alloc] init];
    return __sharedInstance;
}

- (void)saveContext
{
    NSError *error = nil;
    // Salva apenas se houve alterações
    if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
        NSLog(@"Erro ao salvar o contexto: %@, %@", error, [error userInfo]);
    }
}

- (void)rollbackContext {
    // Cancela apenas se houve alterações
    if ([self.managedObjectContext hasChanges]) {
        [self.managedObjectContext rollback];
    }
}

- (id)newManagedObjectForClass:(Class)clazz
{
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(clazz) inManagedObjectContext:self.managedObjectContext];
}

- (NSArray*)executeFetchRequest:(NSFetchRequest *)fetchRequest
{
    NSError* error;
    NSArray* result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Erro ao executar fetchRequest: %@ %@", error, [error userInfo]);
    }
    return result;
}

#pragma mark - Implementação e sobrescrita das Propriedades

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (!_managedObjectModel) {
        
        // URL para o arquivo do DataModel
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kManagedObjectModelName withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (!_persistentStoreCoordinator) {
        
        // URL para o arquivo do banco de dados
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kPersistentStoreFilename];
        
        NSError *error = nil;
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        // Habilita migration e criação do modelo automática
        NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        
        // Trata o erro
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            NSLog(@"Erro ao criar persistentStoreCoordinator:%@, %@", error, [error userInfo]);
        }
    }
    return _persistentStoreCoordinator;
}

#pragma mark - Métodos privados

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
