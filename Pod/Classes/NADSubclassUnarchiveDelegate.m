//
//  NADSubclassUnarchiveDelegate.m
//  Node Archive Delegate
//
//  Created by Stephen Fortune on 22/03/2015.
//  Copyright (c) 2015 IceCube Software Ltd. All rights reserved.
//

#import "EULLNodeSubclassUnarchiveDelegate.h"

@interface NADSubclassUnarchiveDelegate ()

@property (nonatomic, strong) NSMutableDictionary *registeredMappings;

@end

@implementation NADSubclassUnarchiveDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        _registeredMappings = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)registerSubclassClass:(Class)subclass forNodeNamed:(NSString *)nodeName {
    self.registeredMappings[nodeName] = subclass;
}

- (void)registerSubclassClass:(Class)subclass forNodeNames:(NSArray *)nodeNames {
    [nodeNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
        [self.registeredMappings setValue:subclass forKey:name];
    }];
}

- (SKNode *)mappedNodeFromNode:(SKNode *)node {
    
    NSData *archivedNode = [NSKeyedArchiver archivedDataWithRootObject:node];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:archivedNode];
    [unarchiver setClass:(Class)self.registeredMappings[node.name] forClassName:NSStringFromClass(node.class)];
    SKNode *replacementNode = [unarchiver decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [unarchiver finishDecoding];
    return replacementNode;

}

- (id)unarchiver:(NSKeyedUnarchiver *)unarchiver didDecodeObject:(id)object {
    id returnObject;
    SKNode *nodeObject = (SKNode *)object;
    if ([nodeObject isKindOfClass:[SKNode class]] && self.registeredMappings[nodeObject.name]) {
        returnObject = [self mappedNodeFromNode:object];
    } else {
        returnObject = object;
    }
    return returnObject;
}

@end

