//
//  NADSubclassUnarchiveDelegate.h
//  Node Archive Delegate
//
//  Created by Stephen Fortune on 22/03/2015.
//  Copyright (c) 2015 IceCube Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NADSubclassUnarchiveDelegate : NSObject <NSKeyedUnarchiverDelegate>

/**
 
 Registers a subclass mapping. During the decoding process `SKNode`s with the given
 `nodeName`s will be cloned into instances of type `subclass`. The result allows you to 
 sneakily register a custom classes for nodes that you configure via IB's new SpriteKite
 scene editor
 
 @param     subclass        The actual class to associate with the node of the give
                            name.
 @param     nodeName        The name of the node to subclass.
 
 */
- (void)registerSubclassClass:(Class)subclass forNodeNamed:(NSString *)nodeName;

/**
 
 Same as `registerSubclassClass:forNodeNamed:` it just allows you to associated 1 class
 with multiple node names in 1 go.
 
 @param     subclass        The actual class to associate with the node names.
 @param     nodeNames       An array of node names to associate with the class.
 
 */
- (void)registerSubclassClass:(Class)subclass forNodeNames:(NSArray *)nodeNames;

@end
