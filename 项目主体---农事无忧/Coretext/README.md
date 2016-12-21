---
title: CoreText 入门
date: 2016-10-09 16:31:54
categories: 技术
tags: CoreText
---
 

CoreText认识
===
> Core Text is an advanced, low-level technology for laying out text and handling fonts. The Core Text API, introduced in Mac OS X v10.5 and iOS 3.2, is accessible from all OS X and iOS environments.

**Important**: Core Text is intended for developers who must do text layout and font handling at a low level, such as developers of layout engines. You should develop your app using a higher-level framework if possible—that is, use Text Kit in iOS \(see Text Programming Guide for iOS\) or the Cocoa text system in OS X \(see a target="\_self" Cocoa Text Architecture Guide\/a\). Core Text is the technology underlying those text systems, so they share in its speed and efficiency. In addition, Text Kit and the Cocoa text system provide rich text editing, full-featured page layout engines, and other infrastructure that your app would otherwise need to provide if it used Core Text alone.

**CoreText** 是用于处理文字和字体的底层技术。它直接和 Core Graphics（又被称为 Quartz）打交道。Quartz 是一个 2D 图形渲染引擎，能够处理 OSX 和 iOS 中的图形显示。

Quartz 能够直接处理字体（font）和字形（glyphs），将文字渲染到界面上，它是基础库中唯一能够处理字形的模块。因此，CoreText 为了排版，需要将显示的文本内容、位置、字体、字形直接传递给 Quartz。相比其它 UI 组件，由于 CoreText 直接和 Quartz 来交互，所以它具有高速的排版效果。

![](http://xiangwangfeng.com/images/ct6.jpg)

下图是 CoreText 的架构图，可以看到，CoreText 处于非常底层的位置，上层的 UI 控件（包括 UILabel，UITextField 以及 UITextView）和 UIWebView 都是基于 CoreText 来实现的。

![](http://tangqiao.b0.upaiyun.com/coretext/coretext_arch.png)


 **Tips:**

> 在面向对象编程领域中，单一功能原则（Single responsibility principle）规定每个类都应该有一个单一的功能，并且该功能应该由这个类完全封装起来。所有它的（这个类的）服务都应该严密的和该功能平行（功能平行，意味着没有依赖）.








Core Text知识准备
===
 **1.字符（Character）和字形（Glyphs）
** 
> 排版系统中文本显示的一个重要的过程就是字符到字形的转换，字符是信息本身的元素，而字形是字符的图形表征，字符还会有其它表征比如发音。 字符在计算机中其实就是一个编码，某个字符集中的编码，比如Unicode字符集，就囊括了大都数存在的字符。 而字形则是图形，一般都存储在字体文件中，字形也有它的编码，也就是它在字体中的索引。 一个字符可以对应多个字形（不同的字体，或者同种字体的不同样式:粗体斜体等）；多个字符也可能对应一个字形，比如字符的连写（ Ligatures）。

![](http://ww1.sinaimg.cn/large/65cc0af7gw1e2u5ypr899g.gif)

 Roman Ligatures

下面就来详情看看字形的各个参数也就是所谓的字形度量Glyph Metrics

![](http://ww3.sinaimg.cn/large/65cc0af7jw1e2ucdlrkfbg.gif)

![](http://ww2.sinaimg.cn/large/65cc0af7gw1e2u242uytyg.gif)
![2016122114822846996545.jpg](http://7xux50.com2.z0.glb.clouddn.com/2016122114822846996545.jpg?imageView2/0/format/jpg)

**bounding box（边界框 bbox）**，这是一个假想的框子，它尽可能紧密的装入字形。

**baseline（基线）**，一条假想的线,一行上的字形都以此线作为上下位置的参考，在这条线的左侧存在一个点叫做基线的原点，

**ascent（上行高度**）从原点到字体中最高（这里的高深都是以基线为参照线的）的字形的顶部的距离，ascent是一个正值

**descent（下行高度）**从原点到字体中最深的字形底部的距离，descent是一个负值（比如一个字体原点到最深的字形的底部的距离为2，那么descent就为-2）

**linegap（行距**），linegap也可以称作leading（其实准确点讲应该叫做External leading）,行高lineHeight则可以通过 ascent + descent + linegap 来计算。

** 2.坐标系 **

>首先不得不说 苹果编程中的坐标系花样百出，经常让开发者措手不及。 传统的Mac中的坐标系的原点在左下角，比如NSView默认的坐标系，原点就在左下角。但Mac中有些View为了其实现的便捷将原点变换到左上角，像NSTableView的坐标系坐标原点就在左上角。iOS UIKit的UIView的坐标系原点在左上角。  往底层看，Core Graphics的context使用的坐标系的原点是在左下角。而在iOS中的底层界面绘制就是通过Core Graphics进行的，那么坐标系列是如何变换的呢？ 在UIView的drawRect方法中我们可以通过UIGraphicsGetCurrentContext()来获得当前的Graphics Context。drawRect方法在被调用前，这个Graphics Context被创建和配置好，你只管使用便是。如果你细心，通过CGContextGetCTM(CGContextRef c)可以看到其返回的值并不是CGAffineTransformIdentity，通过打印出来看到值为

```

Printing description of contextCTM: (CGAffineTransform) contextCTM = { a = 1 b = 0 c = 0 d = -1 tx = 0 ty = 460 }

```

这是非retina分辨率下的结果，如果是如果是retina上面的a,d,ty的值将会乘2，如果是iPhone 5，ty的值会再大些。 但是作用都是一样的就是将上下文空间坐标系进行了flip，使得原本左下角原点变到左上角，y轴正方向也变换成向下。

上面说了一大堆，下面进入正题，Core Text一开始便是定位于桌面的排版系统，使用了传统的原点在左下角的坐标系，所以它在绘制文本的时候都是参照左下角的原点进行绘制的。 但是iOS的UIView的drawRect方法的context被做了次flip，如果你啥也不做处理，直接在这个context上进行Core Text绘制，你会发现文字是镜像且上下颠倒。

![](http://ww4.sinaimg.cn/large/65cc0af7gw1e2uwkpr6rfj.jpg)

所以在UIView的drawRect方法中的context上进行Core Text绘制之前需要对context进行一次Flip。

![](http://ww1.sinaimg.cn/large/65cc0af7gw1e2uwlh7zvej.jpg)

这里再提及一个函数CGContextSetTextMatrix，它可以用来为每一个显示的字形单独设置变形矩阵。

```

 CGContextSetTextMatrix(context, CGAffineTransformIdentity); CGContextTranslateCTM(context, 0, self.bounds.size.height); CGContextScaleCTM(context, 1.0, -1.0);

```

** 3.NSMutableAttributedString 和 CFMutableAttributedStringRef **

Core Foundation和Foundation中的有些数据类型只需要简单的强制类型转换就可以互换使用，这类类型我们叫他们为[Toll-Free Bridged Types](https://developer.apple.com/library/content/documentation/CoreFoundation/Conceptual/CFDesignConcepts/Articles/tollFreeBridgedTypes.html)。  CFMutableAttributedStringRef和NSMutableAttributedString就是其中的一对，Core Foundation的接口基本是C的接口，功能强大，但是使用起来没有Foundation中提供的Objc的接口简单好使，所以很多时候我们可以使用高层接口组织数据，然后将其传给低层函数接口使用。

 

Core Text对象模型 
===
>这节主要来看看Core Text绘制的一些细节问题了


**首先是Core Text绘制的流程：**
![](http://ww1.sinaimg.cn/large/65cc0af7gw1e2uxd1gmhwj.jpg)

![](http://ww4.sinaimg.cn/large/65cc0af7gw1e2uyn6r88oj.jpg)

* **framesetter** framesetter对应的类型是 CTFramesetter，通过CFAttributedString进行初始化，它作为CTFrame对象的生产工厂，负责根据path生产对应的CTFrame

* **CTFrame** CTFrame是可以通过CTFrameDraw函数直接绘制到context上的，当然你可以在绘制之前，操作CTFrame中的CTLine，进行一些参数的微调

* **CTLine** 可以看做Core Text绘制中的一行的对象 通过它可以获得当前行的line ascent,line descent ,line leading,还可以获得Line下的所有Glyph Runs

* **CTRun** 或者叫做 Glyph Run，是一组共享想相同attributes（属性）的字形的集合体

>上面说了这么多对也没一个东西和图片绘制有关系，其实吧，Core Text本身并不支持图片绘制，图片的绘制你还得通过Core Graphics来进行。只是Core Text可以通过CTRun的设置为你的图片在文本绘制的过程中留出适当的空间。这个设置就使用到CTRunDelegate了，看这个名字大概就可以知道什么意思了，CTRunDelegate作为CTRun相关属性或操作扩展的一个入口，使得我们可以对CTRun做一些自定义的行为。为图片留位置的方法就是加入一个空白的CTRun，自定义其ascent，descent，width等参数，使得绘制文本的时候留下空白位置给相应的图片。然后图片在相应的空白位置上使用Core Graphics接口进行绘制。  使用CTRunDelegateCreate可以创建一个CTRunDelegate，它接收两个参数，一个是callbacks结构体，一个是所有callback调用的时候需要传入的对象。 callbacks的结构体为CTRunDelegateCallbacks，主要是包含一些回调函数，比如有返回当前run的ascent，descent，width这些值的回调函数，至于函数中如何鉴别当前是哪个run，可以在CTRunDelegateCreate的第二个参数来达到目的，因为CTRunDelegateCreate的第二个参数会作为每一个回调调用时的入参。

Laying Out a Paragraph(段落布局)
===
**Before**
---
>To lay out the paragraph, you need a graphics context to draw into, a rectangular path to provide the area where the text is laid out, and an attributed string. Most of the code in this example is required to create and initialize the context, path, and string.

This code could reside in the `drawRect`: method of a `UIView` subclass

```
- (void)drawRect:(CGRect)rect {
    
    
    // Initialize a graphics context in iOS.
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    // Flip the context coordinates, in iOS only.
    
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    
    
    
    // Initializing a graphic context in OS X is different:
    
    // CGContextRef context =
    
    //     (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    
    
    
    // Set the text matrix.
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    
    
    // Create a path which bounds the area where you will be drawing text.
    
    // The path need not be rectangular.
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    
    
    // In this simple example, initialize a rectangular path.
    
    CGRect bounds = CGRectMake(10.0, 0.0, 100.0, 200.0);
    
    CGPathAddRect(path, NULL, bounds );
    
    
    
    // Initialize a string.
    
    CFStringRef textString = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
    
    
    
    // Create a mutable attributed string with a max length of 0.
    
    // The max length is a hint as to how much internal storage to reserve.
    
    // 0 means no hint.
    
    CFMutableAttributedStringRef attrString =
    
    CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    
    
    
    // Copy the textString into the newly created attrString
    
    CFAttributedStringReplaceString (attrString, CFRangeMake(0, 0),
                                     
                                     textString);
    
    
    
    // Create a color that will be added as an attribute to the attrString.
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat components[] = { 1.0, 0.0, 0.0, 0.8 };
    
    CGColorRef red = CGColorCreate(rgbColorSpace, components);
    
    CGColorSpaceRelease(rgbColorSpace);
    
    
    
    // Set the color of the first 12 chars to red.
    
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 12),kCTForegroundColorAttributeName, red);
    
    
    
    // Create the framesetter with the attributed string.
    
    CTFramesetterRef framesetter =
    
    CTFramesetterCreateWithAttributedString(attrString);
    
    CFRelease(attrString);
    
    
    
    // Create a frame.
    /**
     *  <#Description#>
     *
     *  @param framesetter <#framesetter description#>
     *  @param 0           长度(从第几个开始显示)和宽度(显示字节数) (0,0)不限制显示
     *  @param 0           <#0 description#>
     *
     *  @return <#return value description#>
     */
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                
                                                CFRangeMake(0, 0), path, NULL);
    
    
    
    // Draw the specified frame in the given context.
    
    CTFrameDraw(frame, context);
    
    
    
    // Release the objects we used.
    
    CFRelease(frame);
    
    CFRelease(path);
    
    CFRelease(framesetter);
    

}

```

Simple Text Label
===
>简单的标签布局

```
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CFStringRef string = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
    CFStringRef fontName =CFSTR("Papyrus");
    
    CTFontRef  font =
    CTFontCreateWithName(fontName, 15, NULL);
    CGContextRef context = UIGraphicsGetCurrentContext();
   // CGContextTranslateCTM(context, 0, self.bounds.size.height);
    
    // CGContextScaleCTM(context, 1.0, -1.0);

    // Initialize the string, font, and context
    
    
    
    CFStringRef keys[] = { kCTFontAttributeName };
    
    CFTypeRef values[] = { font };
    
    
    
    CFDictionaryRef attributes =
    
    CFDictionaryCreate(kCFAllocatorDefault,(const void**)&keys,
                       
                     (const void**)&values, sizeof(keys) / sizeof(keys[0]),
                       
                       &kCFTypeDictionaryKeyCallBacks,

                       &kCFTypeDictionaryValueCallBacks);
    
    
    
    CFAttributedStringRef attrString =
    
    CFAttributedStringCreate(kCFAllocatorDefault, string, attributes);
    
    CFRelease(string);
    
    CFRelease(attributes);
    
    
    
    CTLineRef line = CTLineCreateWithAttributedString(attrString);
    
    
    
    // Set text position and draw the line into the graphics context
    
    CGContextSetTextPosition(context, 100, 10);
    
    CTLineDraw(line, context);
    
    CFRelease(line);
}

```
在这里我们来探讨一下OSX和iOS坐标系转换的关系
---
>了解两个函数

```
 CGContextTranslateCTM(context, 0, self.bounds.size.height); 
 CGContextScaleCTM(context, 1.0, -1.0);
```
**what's meanning?**
```
 void CGContextTranslateCTM ( CGContextRef c, CGFloat tx, CGFloat ty );
```
 
**Parameters**
*  `c`
*A graphics context.*
*  `tx`	
*The amount to displace the x-axis of the coordinate space, in units of the user space, of the specified context.*
*  `ty`
*The amount to displace the y-axis of the coordinate space, in units of the user space, of the specified context.*
```
void CGContextScaleCTM ( CGContextRef c, CGFloat sx, CGFloat sy )
```
**Parameters**
`c`	
*A graphics context.*
`sx`	
*The factor by which to scale the x-axis of the coordinate space of the specified context.*
`sy`	
*The factor by which to scale the y-axis of the coordinate space of the specified context.*

改变三个参数来看看效果

```
 CGContextTranslateCTM(context, 0, self.bounds.size.height); 
 CGContextScaleCTM(context, 1.0, -1.0);
 CGContextSetTextPosition(context, 100, 10);

```

**第一个改变`CGContextSetTextPosition(context, x, 10)`中x的值**

* x=10

![20161219148214987090595.jpg](http://7xux50.com2.z0.glb.clouddn.com/20161219148214987090595.jpg?imageView2/0/format/jpg)

----------
* x=100

![20161219148215001527630.jpg](http://7xux50.com2.z0.glb.clouddn.com/20161219148215001527630.jpg?imageView2/0/format/jpg)

----------
* x=-100

![2016121914821501244382.jpg](http://7xux50.com2.z0.glb.clouddn.com/2016121914821501244382.jpg?imageView2/0/format/jpg)

>x控制左右移动

----------
* y=100

![20161219148215025125706.jpg](http://7xux50.com2.z0.glb.clouddn.com/20161219148215025125706.jpg?imageView2/0/format/jpg)

----------
* y=50

![20161219148215032912970.jpg](http://7xux50.com2.z0.glb.clouddn.com/20161219148215032912970.jpg?imageView2/0/format/jpg)

----------
* y=-10

![20161219148215040140848.jpg](http://7xux50.com2.z0.glb.clouddn.com/20161219148215040140848.jpg?imageView2/0/format/jpg)

>y控制竖直方向

----------
**第二个改变`CGContextTranslateCTM(context, 0, y)`中y的值;**

* y=20

![20161219148215067551448.jpg](http://7xux50.com2.z0.glb.clouddn.com/20161219148215067551448.jpg?imageView2/0/format/jpg)

* y=100

![20161219148215075086710.jpg](http://7xux50.com2.z0.glb.clouddn.com/20161219148215075086710.jpg?imageView2/0/format/jpg)

* y =-50
 空白

>y控制上下移

**第三个改变`CGContextTranslateCTM(context,x *1.0,y *1.0)`中x,y的值;** 
>x=1.0 y= -1.0

![2016121914821521365588.jpg](http://7xux50.com2.z0.glb.clouddn.com/2016121914821521365588.jpg?imageView2/0/format/jpg)

----------
>x=0.5 y =- 1.0

![2016121914821513271334.jpg](http://7xux50.com2.z0.glb.clouddn.com/2016121914821513271334.jpg?imageView2/0/format/jpg)

----------
>x=0.3 y =- 1.0

![20161219148215145682042.jpg](http://7xux50.com2.z0.glb.clouddn.com/20161219148215145682042.jpg?imageView2/0/format/jpg)


----------
>x =1.0 y =-0.5

![20161219148215164663809.jpg](http://7xux50.com2.z0.glb.clouddn.com/20161219148215164663809.jpg?imageView2/0/format/jpg)

----------
>x =1.0 y= -0.3

![20161219148215188029737.jpg](http://7xux50.com2.z0.glb.clouddn.com/20161219148215188029737.jpg?imageView2/0/format/jpg)

----------
>x =1.0 y= 0

![20161219148215223889945.jpg](http://7xux50.com2.z0.glb.clouddn.com/20161219148215223889945.jpg?imageView2/0/format/jpg)

----------
>x =1.0 y=1.0

**空白**

----------
Columnar Layout(列布局)
---

```
- (void)drawRect:(CGRect)rect {
    // Drawing code
    // Initialize a graphics context in iOS.
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    // Flip the context coordinates in iOS only.
    
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    
    
    
    // Initializing a graphic context in OS X is different:
    
    // CGContextRef context =
    
    //     (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    
    
    
    // Set the text matrix.
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    
    
    // Create the framesetter with the attributed string.
    CFStringRef fontName =CFSTR("Papyrus");
    
    CTFontRef  font =
    CTFontCreateWithName(fontName, 15, NULL);
    
    CFStringRef keys[] = { kCTFontAttributeName };
    
    
    CFTypeRef values[] = { font };
    
    
    
    CFDictionaryRef attributes =
    
    CFDictionaryCreate(kCFAllocatorDefault,(const void**)&keys,
                       
                       (const void**)&values, sizeof(keys) / sizeof(keys[0]),
                       
                       &kCFTypeDictionaryKeyCallBacks,
                       
                       &kCFTypeDictionaryValueCallBacks);
    
       CFStringRef string = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
    
    CFAttributedStringRef attrString =
    
    CFAttributedStringCreate(kCFAllocatorDefault, string, attributes);

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
    
    
    
    // Call createColumnsWithColumnCount function to create an array of
    
    // three paths (columns).
    
    CFArrayRef columnPaths = [self createColumnsWithColumnCount:3];
    
    
    
    CFIndex pathCount = CFArrayGetCount(columnPaths);
    
    CFIndex startIndex = 0;
    
    int column;
    
    
    
    // Create a frame for each column (path).
    
    for (column = 0; column < pathCount; column++) {
        
        // Get the path for this column.
        
        CGPathRef path = (CGPathRef)CFArrayGetValueAtIndex(columnPaths, column);
        
        
        
        // Create a frame for this column and draw it.
        
        CTFrameRef frame = CTFramesetterCreateFrame(
                                                    
                                                    framesetter, CFRangeMake(startIndex, 0), path, NULL);
        
        CTFrameDraw(frame, context);
        
        
        
        // Start the next frame at the first character not visible in this frame.
        
        CFRange frameRange = CTFrameGetVisibleStringRange(frame);
        
        startIndex += frameRange.length;
        
        CFRelease(frame);
        
        
        
    }
    
    CFRelease(columnPaths);
    
    CFRelease(framesetter);
}

  //计算列数
- (CFArrayRef)createColumnsWithColumnCount:(int)columnCount

{
    
    int column;
    
    
    
    CGRect* columnRects = (CGRect*)calloc(columnCount, sizeof(*columnRects));
    
    // Set the first column to cover the entire view.
    
    columnRects[0] = self.bounds;
    
    
    
    // Divide the columns equally across the frame's width.
    
    CGFloat columnWidth = CGRectGetWidth(self.bounds) / columnCount;
    
    for (column = 0; column < columnCount - 1; column++) {
        
        CGRectDivide(columnRects[column], &columnRects[column],
                     
                     &columnRects[column + 1], columnWidth, CGRectMinXEdge);
        
    }
    
    
    
    // Inset all columns by a few pixels of margin.
    
    for (column = 0; column < columnCount; column++) {
        
        columnRects[column] = CGRectInset(columnRects[column], 8.0, 15.0);
        
    }
    
    
    
    // Create an array of layout paths, one for each column.
    
    CFMutableArrayRef array =
    
    CFArrayCreateMutable(kCFAllocatorDefault,
                         
                         columnCount, &kCFTypeArrayCallBacks);
    
    
    
    for (column = 0; column < columnCount; column++) {
        
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathAddRect(path, NULL, columnRects[column]);
        
        CFArrayInsertValueAtIndex(array, column, path);
        
        CFRelease(path);
        
    }
    
    free(columnRects);
    
    return array;
    
}

```

效果如图:

![20161220148220156666279.jpg](http://7xux50.com2.z0.glb.clouddn.com/20161220148220156666279.jpg?imageView2/0/format/jpg)
Manual Line Breaking(截断布局)
---
```
- (void)drawRect:(CGRect)rect {
    // Drawing code
    double width; CGContextRef context; CGPoint textPosition; CFAttributedStringRef attrString;
    // Initialize those variables.
     CFStringRef string = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
    //冲掉150字节后面的字符串
    width = 150.0;
    context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, self.frame.size.height);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    
   //起始位置
    textPosition = CGPointMake(10.0, 50.0);
    //字形
    CFStringRef fontName =CFSTR(/*"Papyrus"*/"HanziPenSC-W3");
    
    CTFontRef  font =
    CTFontCreateWithName(fontName, 15, NULL);
    //笔调重描痕迹
    CGFloat number = 3.0;
    
    CFNumberRef strokeWidth = CFNumberCreate(kCFAllocatorDefault, kCFNumberCGFloatType, &number  );
    //笔调颜色重描痕迹
    CGColorSpaceRef space =   CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {1.0,0.0,0.0,0.8};
    CGColorRef color = CGColorCreate(space, components);
    // Controls vertical text positioning
    CGFloat superScriptnumber = -1.0;
    
    CFNumberRef superScript = CFNumberCreate(kCFAllocatorDefault, kCFNumberCGFloatType, &superScriptnumber  );
    //kCTUnderlineStyleAttributeName
    /**
     *    kCTUnderlineStyleNone           = 0x00,
     kCTUnderlineStyleSingle         = 0x01,
     kCTUnderlineStyleThick          = 0x02,
     kCTUnderlineStyleDouble         = 0x09
     */
    CGFloat UnderlineStylenumber =kCTUnderlinePatternDash| kCTUnderlineStyleDouble;
    
    CFNumberRef UnderlineStyle = CFNumberCreate(kCFAllocatorDefault, kCFNumberCGFloatType, &UnderlineStylenumber  );
    //kCTUnderlineColorAttributeName
    CGColorSpaceRef Underlinespace =   CGColorSpaceCreateDeviceRGB();
    CGFloat Underlinecomponents[] = {0.0,0.5,0.5,1};
    CGColorRef Underlinecolor = CGColorCreate(Underlinespace, Underlinecomponents);
    //kCTVerticalFormsAttributeName 文字方向
    CFBooleanRef t = kCFBooleanFalse;
    
 /*   //kCTGlyphInfoAttributeName  字形信息
    CFStringRef glyphName = CFSTR("lessequal");
    CFStringRef baseString = CFSTR("Hello");
    CFStringRef GlyphInfofontName =CFSTR("HanziPenSC-W3");
    
    CTFontRef  GlyphInfofont =
    CTFontCreateWithName(GlyphInfofontName, 30, NULL);
    CTGlyphInfoRef info = CTGlyphInfoCreateWithGlyphName(glyphName, GlyphInfofont, string);
  */
    CFStringRef keys[] = { kCTFontAttributeName,kCTStrokeWidthAttributeName ,kCTStrokeColorAttributeName,kCTSuperscriptAttributeName,kCTUnderlineColorAttributeName,kCTUnderlineStyleAttributeName,kCTVerticalFormsAttributeName/*,kCTGlyphInfoAttributeName*/ };
   
    CFTypeRef values[] = { font ,strokeWidth,color,superScript,Underlinecolor, UnderlineStyle  ,t/*,info*/};
    
    
    
    CFDictionaryRef attributes =
    
    CFDictionaryCreate(kCFAllocatorDefault,(const void**)&keys,
                       
                       (const void**)&values,sizeof(keys)/sizeof(keys[0]) ,
                       
                       &kCFTypeDictionaryKeyCallBacks,
                       
                       &kCFTypeDictionaryValueCallBacks);
    
   
    
      attrString =   CFAttributedStringCreate(kCFAllocatorDefault, string, attributes);
  
    // Create a typesetter using the attributed string.
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString(attrString);
    
    // Find a break for line from the beginning of the string to the given width.
    CFIndex start = 0;
    CFIndex count = CTTypesetterSuggestLineBreak(typesetter, start, width);
    
    // Use the returned character count (to the break) to create the line.
    CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
    
    // Get the offset needed to center the line.
    float flush = 0.5; // centered
    double penOffset = CTLineGetPenOffsetForFlush(line, flush, width);
    
    // Move the given text drawing position by the calculated offset and draw the line.
    CGContextSetTextPosition(context, textPosition.x + penOffset, textPosition.y);
    CTLineDraw(line, context);
    
    // Move the index beyond the line break.
    start += count;
        CGColorRelease(color);
    CGColorRelease(Underlinecolor);
    CGColorSpaceRelease(Underlinespace);
      CGColorSpaceRelease(space);
}

```
效果图
![20161220148221767315005.jpg](http://7xux50.com2.z0.glb.clouddn.com/20161220148221767315005.jpg?imageView2/0/format/jpg)

Applying a Paragraph Style(应用段落格式)
---
```
NSAttributedString* applyParaStyle(
                CFStringRef fontName , CGFloat pointSize,
                NSString *plainText, CGFloat lineSpaceInc){
 
    // Create the font so we can determine its height.
    CTFontRef font = CTFontCreateWithName(fontName, pointSize, NULL);
 
    // Set the lineSpacing.
    CGFloat lineSpacing = (CTFontGetLeading(font) + lineSpaceInc) * 2;
 
    // Create the paragraph style settings.
    CTParagraphStyleSetting setting;
 
    setting.spec = kCTParagraphStyleSpecifierLineSpacing;
    setting.valueSize = sizeof(CGFloat);
    setting.value = &lineSpacing;
 
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(&setting, 1);
 
    // Add the paragraph style to the dictionary.
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                               (__bridge id)font, (id)kCTFontNameAttribute,
                               (__bridge id)paragraphStyle,
                               (id)kCTParagraphStyleAttributeName, nil];
    CFRelease(font);
    CFRelease(paragraphStyle);
 
    // Apply the paragraph style to the string to created the attributed string.
    NSAttributedString* attrString = [[NSAttributedString alloc]
                               initWithString:(NSString*)plainText
                               attributes:attributes];
 
    return attrString;
}
//In Listing 2-7, the styled string is used to create a framesetter. The code uses the framesetter to create a frame and draws the frame.

//Listing 2-7  Drawing the styled paragraph
- (void)drawRect:(CGRect)rect {
    // Initialize a graphics context in iOS.
    CGContextRef context = UIGraphicsGetCurrentContext();
 
    // Flip the context coordinates in iOS only.
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
 
    // Set the text matrix.
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
 
    CFStringRef fontName = CFSTR("Didot Italic");
    CGFloat pointSize = 24.0;
 
    CFStringRef string = CFSTR("Hello, World! I know nothing in the world that has
                                   as much power as a word. Sometimes I write one,
                                   and I look at it, until it begins to shine.");
 
    // Apply the paragraph style.
    NSAttributedString* attrString = applyParaStyle(fontName, pointSize, string, 50.0);
 
    // Put the attributed string with applied paragraph style into a framesetter.
    CTFramesetterRef framesetter =
             CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
 
    // Create a path to fill the View.
    CGPathRef path = CGPathCreateWithRect(rect, NULL);
 
    // Create a frame in which to draw.
    CTFrameRef frame = CTFramesetterCreateFrame(
                                    framesetter, CFRangeMake(0, 0), path, NULL);
 
    // Draw the frame.
    CTFrameDraw(frame, context);
    CFRelease(frame);
    CGPathRelease(path);
    CFRelease(framesetter);
}
```
Displaying Text in a Nonrectangular Region(非矩形区域展示)
---
>在一个非矩形区域内展示文字最困难的部分就是描述路径.
**效果图:**
![20161220148222791854140.jpg](http://7xux50.com2.z0.glb.clouddn.com/20161220148222791854140.jpg?imageView2/0/format/jpg)

```
// Create a path in the shape of a donut.
static void AddSquashedDonutPath(CGMutablePathRef path,
                                 const CGAffineTransform *m, CGRect rect)
{
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    CGFloat radiusH = width / 3.0;
    CGFloat radiusV = height / 3.0;
    
    CGPathMoveToPoint( path, m, rect.origin.x, rect.origin.y + height - radiusV);
    CGPathAddQuadCurveToPoint( path, m, rect.origin.x, rect.origin.y + height,
                              rect.origin.x + radiusH, rect.origin.y + height);
    CGPathAddLineToPoint( path, m, rect.origin.x + width - radiusH,
                         rect.origin.y + height);
    CGPathAddQuadCurveToPoint( path, m, rect.origin.x + width,
                              rect.origin.y + height,
                              rect.origin.x + width,
                              rect.origin.y + height - radiusV);
    CGPathAddLineToPoint( path, m, rect.origin.x + width,
                         rect.origin.y + radiusV);
    CGPathAddQuadCurveToPoint( path, m, rect.origin.x + width, rect.origin.y,
                              rect.origin.x + width - radiusH, rect.origin.y);
    CGPathAddLineToPoint( path, m, rect.origin.x + radiusH, rect.origin.y);
    CGPathAddQuadCurveToPoint( path, m, rect.origin.x, rect.origin.y,
                              rect.origin.x, rect.origin.y + radiusV);
    CGPathCloseSubpath( path);
    
    CGPathAddEllipseInRect( path, m,
                           CGRectMake( rect.origin.x + width / 2.0 - width / 5.0,
                                      rect.origin.y + height / 2.0 - height / 5.0,
                                      width / 5.0 * 2.0, height / 5.0 * 2.0));
}

// Generate the path outside of the drawRect call so the path is calculated only once.
- (NSArray *)paths
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, 20.0, 10.0);
    AddSquashedDonutPath(path, NULL, bounds);
    
    NSMutableArray *result =
    [NSMutableArray arrayWithObject:CFBridgingRelease(path)];
    return result;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // Initialize a graphics context in iOS.
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Flip the context coordinates in iOS only.
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // Set the text matrix.
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    // Initialize an attributed string.
    CFStringRef textString = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shineHello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine");
                                   
                                   // Create a mutable attributed string.
                                   CFMutableAttributedStringRef attrString =
                                   CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
                                   
                                   // Copy the textString into the newly created attrString.
                                   CFAttributedStringReplaceString (attrString, CFRangeMake(0, 0), textString);
                                   
                                   // Create a color that will be added as an attribute to the attrString.
                                   CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
                                   CGFloat components[] = { 1.0, 0.0, 0.0, 0.8 };
                                   CGColorRef red = CGColorCreate(rgbColorSpace, components);
                                   CGColorSpaceRelease(rgbColorSpace);
                                   
                                   // Set the color of the first 13 chars to red.
                                   CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 13),
                                                                  kCTForegroundColorAttributeName, red);
                                   
                                   // Create the framesetter with the attributed string.
                                   CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
                                   
                                   // Create the array of paths in which to draw the text.
                                   NSArray *paths = [self paths];
                                   
                                   CFIndex startIndex = 0;
                                   
                                   // In OS X, use NSColor instead of UIColor.
#define GREEN_COLOR [UIColor greenColor]
#define YELLOW_COLOR [UIColor yellowColor]
#define BLACK_COLOR [UIColor blackColor]
                                   
                                   // For each path in the array of paths...
                                   for (id object in paths) {
                                       CGPathRef path = (__bridge CGPathRef)object;
                                       
                                       // Set the background of the path to yellow.
                                       CGContextSetFillColorWithColor(context, [YELLOW_COLOR CGColor]);
                                       
                                       CGContextAddPath(context, path);
                                       CGContextFillPath(context);
                                       
                                       CGContextDrawPath(context, kCGPathStroke);
                                       
                                       // Create a frame for this path and draw the text.
                                       CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                                                   CFRangeMake(startIndex, 0), path, NULL);
                                       CTFrameDraw(frame, context);
                                       
                                       // Start the next frame at the first character not visible in this frame.
                                       CFRange frameRange = CTFrameGetVisibleStringRange(frame);
                                       startIndex += frameRange.length;
                                       CFRelease(frame);
                                   }
                                   
                                   CFRelease(attrString);
                                   CFRelease(framesetter);
                                   }

```
随后就学习一下路径的创建
文章参考
---
*  <http://www.saitjr.com/ios/use-coretext-make-typesetting-picture-and-text.html>
*  <http://geeklu.com/2013/03/core-text/>

* <http://blog.devtang.com/2015/06/27/using-coretext-2/> (唐巧博客)

[官网](https://developer.apple.com/reference/coretext?language=objc)
---
* <https://developer.apple.com/library/content/documentation/StringsTextFonts/Conceptual/CoreText_Programming/LayoutOperations/LayoutOperations.html#//apple_ref/doc/uid/TP40005533-CH12-SW11>