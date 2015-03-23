#Node Unarchive Delegate

Here's one for you: XCode's new SpriteKit scene editor doesn't allow you to change the class of nodes in the scene like the interface builder does. This is rather inconvenient for example, if you've implemented your own sprite that encapsulates the logic associated with your game's hero; something like...


```Objective-C

@interface MyHeroSprite : SKSpriteNode

- (void)jumpTo:(CGPoint)to;
- (void)levelUp:(MyHeroLevelEnum)level;

@end

@interface MyEnemySprite : SKSpriteNode

@property (nonatomic) BOOL isEvil;
- (void)die;

@end

...

```

This tricksey little class allows you to swap out nodes with your custom subclass by name during the unarchive process. I.e.

```Objective-C

NADSubclassUnarchiveDelegate *delegate = [[NADSubclassUnarchiveDelegate alloc] init];
[delegate registerSubclassClass:[MyHeroSprite class] forNodeNamed:@"Hero"];
[delegate registerSubclassClass:[MyHeroSprite class] forNodeNames:@[ @"Alien1", @"Alien2", @"Alien3", ]];

NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
NSData *data = [NSData dataWithContentsOfFile:nodePath options:NSDataReadingMappedIfSafe error:nil];
NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
arch.delegate = delegate;
[arch setClass:[MyAwesomeScene class] forClassName:@"SKScene"];
MyAwesomeScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
[arch finishDecoding];

...

```

###Is It Hack, or Nah?

Not really sure. It seems valid enough given that I'm making valid use of the `NSKeyedUnarchiverDelegate` to replace decoded objects.

The only questionable architectural decision I've made is using instances `NSKeyedArchiver` and `NSKeyedUnarchiver` witihn the delegate to actually clone the node data into an instance of its subclass.