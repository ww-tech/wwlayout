# Size Classes in Swift
Size classes help you change the layout of views to adapt to various screen sizes, ranging from a tiny iPhone SE to a massive 12.9" iPad Pro. There are 3 different cases for a size class: `regular`, `compact`, and `unspecified`. Size classes are split up into horizontal and vertical classes, allowing you to adapt based on the size of each dimension. In the horizontal case, `regular` applies to all iPads in full screen as well as some iPhones in landscape, `compact` applies to all iPhones in portrait and most iPhones in landscape along with some iPad multitasking configurations, and `unspecified` is the case where it is not yet determined. For a better and more detailed explanation of size classes, check out this great article: https://useyourloaf.com/blog/size-classes/.

## Using Size Classes
Using size classes is pretty simple. Every `UIView` and `UIViewController` has access to a `traitCollection` property, which contains both the horizontal and vertical size classes. You can use these when setting up your views to properly lay out for the current display. Typically, you'll want to just check the horizontal size class, as this is the one that will change when split view is activated on iPad.

## Adapting to Changes in Size Classes
It's also important to properly adjust views when the size class changes. This occurs when your app is used in multitasking split view on iPad or when the device is rotated. This can cause the size class to change from `regular` to `compact`.

In order to respond to these changes, your `UIView` or `UIViewController` needs to override `traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)`, which is called every time the trait collection changes. Inside this method, you want to write something like this:

```swift
public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    guard previousTraitCollection.horizontalSizeClass != traitCollection.horizontalSizeClass else { return }
        
    // Your layout code here
}
```
Note that changes in sizes classes aren't the _only_ reason why this method is called. Whenever any trait changes (such as from dark mode to light mode), this method is called. It's important to check that the size class actually changed in order to avoid any erroneous layout code that isn't needed.

Also note that as of iOS 13, `traitCollectionDidChange` is _not_ always called when a view is loaded. It's important that you also consider the size class in your initial layout code, if necessary. If you want to avoid duplicate code, you can create a helper function that performs all size class dependent layout code, which you can call in both your initial setup and in the `traitCollectionDidChange` method.

## Auto Layout Constraints
In order to change constraints based on size classes, you would typically have to maintain 2 separate collections of constraints and manually activate and deactivate them in your layout code. With the help of WWLayout though, you don't have to do that!

By specifying the horizontal or vertical size class that a set of constraints applies to, WWLayout will automatically respond to changes in size classes and activate the correct constraints. Your code will look something like this:
```swift
        insetView.layout.fill(.safeArea, inset: 20)
        
        squareView.layout
            .below(topOf: insetView, offset: 10)
            .height(.lessOrEqual, to: insetView.layout.height - 20)
            .width(toHeight: 1.0)
            .size(260, priority: .required - 1)
        
        // portrait
        squareView.layout(verticalSize: .compact)
            .center(in: insetView, axis: .x)
        
        label.layout(verticalSize: .regular)
            .fill(insetView, axis: .x, inset: 20)
            .below(squareView, offset: 20)
        
        // landscape
        squareView.layout(verticalSize: .compact)
            .leading(to: insetView, offset: 10)
        
        label.layout(verticalSize: .regular)
            .top(to: insetView, offset: 20)
            .leading(to: squareView, edge: .trailing, offset: 20)
            .trailing(to: insetView, offset: -20)
```

## Accessing Size Class Outside of `UIView` and `UIViewController`
There might be some cases where you want to access the current size class outside of the classes where `traitCollection` is defined, such as in a model object. While iOS 13 introduced the `UITraitCollection.current` property, we need a solution that works on all supported OS versions. 

There are 2 ways to go about this. You can either pass along the trait collection from the `UIView` or you can access it directly by calling `UIScreen.main.traitCollection`. Either way will get you the same results, so choose whichever way works best with your code.

## Moratorium on Device Idioms
Some developers currently use `UIDevice.current.userInterfaceIdiom` to layout their views based on device. While this might work fine if your app is always fullscreen, it is *not* compatible with iPad multitasking. The reason is that this variable simply checks the device idiom and returns either `phone` for iPhones or `pad` for iPads. It does not tell you the current size class or anything about the actual size of the display, nor does it respond to changes in size. Therefore, it should be avoided unless there is something you specifically need to vary between devices.