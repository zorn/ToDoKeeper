//
//  ToDoKeeperAppDelegate.m
//  ToDoKeeper
//
//  Created by Michael Zornek on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ToDoKeeperAppDelegate.h"

#import "ToDoItem.h"

@implementation ToDoKeeperAppDelegate

@synthesize window = _window;
@synthesize tableView = _tableView;
@synthesize toDoItemArrayController = _toDoItemArrayController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Make a default context
    [NSManagedObjectContext setDefaultContext:[NSManagedObjectContext context]];
    
    // manually setup the array controller's source context. Done here rather than the nib since because it is inside the MainMenu nib it's loaded super early and the context wouldn't be set. Alternatively we could create a real ivar and accessor to hold the context here and KVO would kick the binding.
    [self.toDoItemArrayController setManagedObjectContext:[NSManagedObjectContext defaultContext]];
    
    
    /*
    NSString *containerIdentifier = nil;
    
    NSDictionary *entitlements = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Entitlements" ofType:@"entitlements"]];
    
    NSArray *containerIdentifierArray = [entitlements objectForKey:@"com.apple.developer.ubiquity-container-identifiers"];
    
    if (containerIdentifierArray.count > 0) containerIdentifier = [containerIdentifierArray objectAtIndex:0];
    
    if (!containerIdentifier) {
        [[NSException exceptionWithName:NSGenericException
                                 reason:@"CoreDataiCloudSample does not contain a com.apple.developer.ubiquity-container-identifiers entitlement"
                               userInfo:nil] raise];
        
    }
    
    NSURL *storeURL = nil;
    NSURL *cloudURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:containerIdentifier];
    if (cloudURL) {
        NSLog(@"cloudURL %@", cloudURL);
    }
    
    // signup for icloud notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ubiquitousContentDidChange:) name:NSPersistentStoreDidImportUbiquitousContentChangesNotification object:nil]; 
     */
}

- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
    return [[NSManagedObjectContext defaultContext] undoManager];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    if (![[NSManagedObjectContext defaultContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }

    if (![[NSManagedObjectContext defaultContext] hasChanges]) {
        return NSTerminateNow;
    }

    NSError *error = nil;
    if (![[NSManagedObjectContext defaultContext] save]) {

        // Customize this code block to include application-specific recovery steps.              
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }

        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        alert = nil;
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }

    return NSTerminateNow;
}

- (NSManagedObjectContext *)mainContext
{
    return [NSManagedObjectContext defaultContext];
}

- (IBAction)saveAction:(id)sender
{
    [[NSManagedObjectContext defaultContext] save];
}

- (void)ubiquitousContentDidChange:(NSNotification *)note
{
    NSLog(@"ubiquitousContentDidChange note %@", note);
}

@end
