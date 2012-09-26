//
//  ObjectManager.h
//  AddressBook
//
//  Created by Saulo Arruda Coelho on 7/16/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define kManagedObjectModelName @"ClienteModel"
#define kPersistentStoreFilename @"Clientes.sqlite"

@interface ObjectManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

+ (ObjectManager*)sharedInstance;

- (id)newManagedObjectForClass:(Class)clazz;
- (void)saveContext;


@end
