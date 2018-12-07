# Constraining Targets
Constraints are created as a relationship between two items.  Strictly speaking, constraints are from anchor to anchor - e.g., the topAnchor of one view, to the bottomAnchor of another - but it's convenient to think in terms of constraining views to views - e.g., position view A below view B - letting WWLayout create the individual constraints as needed.

In WWLayout, you will start out with the *from* view by accessing the view's `layout` property, and then specify the *to* view within the individual layout methods.

```swift
    theView.layout.fill(anotherView)
```

There are a number of special targets that you can constrain *to*, like the view's parent, or the safe area.  Wherever you can use a UIView as the target, you can also use one of the special targets.

This will make theView fill its superview:

```swift
    theView.layout.fill(.superview)
```

This will make theView fill the safe area:

```swift
    theView.layout.fill(.safeArea)
```

Note that .safeArea is backwards compatible, so that if your app is running pre-iOS 11, the left and right edges of theView will be constrained to theView's superview, while theView's top and bottom edges will be constrained to theView's containing UIVieController's topLayoutGuide and bottomLayoutGuide, respectively.

***

[<- Home](./) | [Middle out parameters ->](middle-out-parameters)
