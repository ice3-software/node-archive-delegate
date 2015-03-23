#Node Unarchive Delegate

Here's one for you: XCode's new SpriteKit scene editor [doesn't allow you to change the class of nodes](http://stackoverflow.com/questions/24466536/how-to-use-spritekit-archives-with-skspritenode-subclasses) in the scene [like interface builder](https://vandadnp.files.wordpress.com/2011/03/myview-class-name-in-interface-builder.png). This is rather inconvenient if for example, you want to setup your custom sprite subclasses in the scene:


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

This [tricksy little class](http://i.ytimg.com/vi/NB2CNr692RE/maxresdefault.jpg) allows you to swap out nodes with your custom subclass by name during the unarchive process. I.e.

```Objective-C

NADSubclassUnarchiveDelegate *delegate = [[NADSubclassUnarchiveDelegate alloc] init];
[delegate registerSubclassClass:[MyHeroSprite class] forNodeNamed:@"Hero"];
[delegate registerSubclassClass:[MyEnemySprite class] forNodeNames:@[ @"Alien1", @"Alien2", @"Alien3", ]];

NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
NSData *data = [NSData dataWithContentsOfFile:nodePath options:NSDataReadingMappedIfSafe error:nil];
NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
arch.delegate = delegate;
[arch setClass:[MyAwesomeScene class] forClassName:@"SKScene"];
MyAwesomeScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
[arch finishDecoding];

...

```

###Is It Hack?

Nah. It seems valid enough given that I'm making valid use of the `NSKeyedUnarchiverDelegate` to replace decoded objects.

The only questionable architectural decision I've made is using instances `NSKeyedArchiver` and `NSKeyedUnarchiver` within the delegate to actually clone the node data into an instance of its subclass.
