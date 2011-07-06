//
//  ToDoItem.h
//  ToDoKeeper
//
//  Created by Michael Zornek on 6/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ToDoItem : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic) BOOL isComplete;

@end
