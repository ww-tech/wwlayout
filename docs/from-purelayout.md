# Migrating from PureLayout
If you are coming from PureLayout, here's what you need to know...

## General guidelines
In PureLayout, you call individual methods on the views that you want to set constraints for.  In WWLayout, you will instead access the view's `layout` property, and call the constraint methods on that.  Furthermore, these methods are chainable, so you only need to access the `layout` property once.

For example, in PureLayout you would do this:
```swift
backButton.autoPinEdge(toSuperviewEdge: .top, withInset: 32)		
backButton.autoPinEdge(toSuperviewEdge: .left, withInset: 15)		
backButton.autoSetDimension(.height, toSize: 21)		
backButton.autoSetDimension(.width, toSize: 12.5)
```

In WWLayout, you would do this instead:
```swift
backButton.layout
   .top(to: .superview, offset: 32)
   .left(to: .superview, offset: 15)
   .size(12.5, 21)
```

### Dealing with edges

Instead of `autoPinEdge`, use the various edge methods (e.g. `top(to:)`, `.left(to:)`) - there's a method for each layout anchor available: `top`, `centerY`, `bottom`, `firstBaseline`, `lastBaseline`, `left`, `right`, `leading`, `training`, `centerX`.

| PureLayout | WWLayout |
| --- | --- |
| `autoPinEdge(toSuperviewEdge: .top, withInset: 32)` | `.top(to: .superview, offset: 32)` |
| `autoPinEdge(.top, to: .bottom, of: otherView, withOffset: 12)` | `.top(to: otherView, edge: .bottom, offset: 12)` or `.below(otherView, offset: 12)` |

For setting up a vertical 'stack' of views, you can use the `.stack` helper, like this:
```swift
containerView.layout.stack([view1, view2, view3, etc], space: 20)
```
Or, if you need different spacing between the views, use the `.below` and `.followedBy` methods:
```swift
view1.layout
   .below(topView, offset: 10)
   .followedBy(view2, offset: 20)
   .followedBy(view3)
   .followedBy(view4, offset: 15)
```

