//
//  ToDoKeeperAppDelegate.h
//  ToDoKeeper
//
//  Created by Michael Zornek on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ToDoKeeperAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *_window;
    NSTableView *_tableView;
    NSArrayController *_toDoItemArrayController;
}

@property (strong) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSTableView *tableView;
@property (strong) IBOutlet NSArrayController *toDoItemArrayController;

- (NSManagedObjectContext *)mainContext;
- (IBAction)saveAction:(id)sender;

@end
