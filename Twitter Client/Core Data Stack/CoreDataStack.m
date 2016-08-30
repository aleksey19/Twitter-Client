//
//  CoreDataStack.m
//  Twitter Client
//
//  Created by Aleksey on 8/30/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation CoreDataStack

#pragma mark - Designated initializer

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self initializeCoreData];
    }
    
    return self;
}

- (void)initializeCoreData
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TopRegions" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(mom != nil, @"Error! Managed Object Model shouldn't be nil");
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [moc setPersistentStoreCoordinator:psc];
    [self setManagedObjectContext:moc];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentURL URLByAppendingPathComponent:@"TopRegions.sqlite"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        NSPersistentStoreCoordinator *psc = self.managedObjectContext.persistentStoreCoordinator;
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
    });
}

#pragma mark - Main context getter

- (NSManagedObjectContext *)getMainObjectContext
{
    return self.managedObjectContext;
}

@end
