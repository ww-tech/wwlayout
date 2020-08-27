# Method Reference

### Size

#### `size()`
```swift
    .size(100)
    .size(200, 150)
```

#### `size(to:)`
```swift
    .size(to: .superview)
    .size(to: otherView)
```

#### `width()`
```swift
    .width(100)
    .width(.greaterOrEqual, to: 100)
```

#### `width(to:)`
```swift
    .width(to: otherView) // constrain to width of another view
    .width(to: .safeArea) // constrain to width of the safe area
    .width(to: otherView.layout.width * 0.5 + 20) // mix-in a multiplier and/or constant
```

#### `width(toHeight:)`
```swift
    .width(toHeight: 2) // width = height * 2.0 (of itself)
    .width(.greaterOrEqual, toHeight: 0.5) // width >= height * 0.5 (of itself)
```

#### `height()`
```swift
    .height(250)
    .height(.lessOrEqual, to: 320)
```

#### `height(to:)`
```swift
    .height(to: otherView) // constrain to height of another view
    .height(to: .safeArea) // constrain to height of the safe area
    .height(to: otherView.layout.height * 0.5 + 20) // mix-in a multiplier and/or constant
```

#### `height(toWidth:)`
```swift
    .height(toWidth: 2) // height = width * 2.0 (of itself)
    .height(.lessOrEqual, toWidth: 2) // height <= width * 2.0 (of itself)
```

### Center
#### `center(in:)`
```swift
    oneView.layout.center(in: .safeArea)
    oneView.layout.center(in: anotherView, axis: .x)
```
You can also constrain from a view's center using the `.centerX(to:)` and `.centerY(to:)` methods, as well as constrain to it's center edges, like: `.top(to: otherView, edge: .center)` (it's just `.center` in this context since the compiler already knows it's a Y constraint).

### Fill

#### `fill()`
```swift
    oneView.layout.fill(anotherView)
    oneView.layout.fill(anotherView, axis: .x)
    oneView.layout.fill(anotherView, except: .bottom)
```

#### `fillWidth()`
```swift
    oneView.layout.fillWidth(anotherView, maximum: 400)
    oneView.layout.fillWidth(anotherView, inset: 20, maximum: 400)
    oneView.layout.fillWidth(anotherView, inset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), maximum: 400)
    oneView.layout.fillWidth(anotherView, inset: 20, maximum: 400, alignTo: .leading)
```

### Set Edges

#### `left(to:)`
```swift
    .left(to: anotherView)
    .left(to: anotherView, edge: .center)
    .left(to: anotherView, offset: 20)
```

#### `centerX(to:)`
```swift
    .centerX(to: anotherView) // Note: same as .center(in: anotherView, axis: .x)
    .centerX(to: anotherView, edge: .right)
    .centerX(to: anotherView, offset: 20)
```

#### `right(to:)`
```swift
    .right(to: anotherView)
    .right(to: anotherView, edge: .center)
    .right(to: anotherView, offset: -20)
```

#### `leading(to:)`
```swift
    .leading(to: anotherView)
    .leading(to: anotherView, edge: .trailing)
    .leading(to: anotherView, offset: 20)
```

#### `trailing(to:)`
```swift
    .trailing(to: anotherView)
    .trailing(to: anotherView, edge: .leading)
    .trailing(to: anotherView, offset: 20)
```

#### `top(to:)`
```swift
    .top(to: anotherView)
    .top(to: .safeArea, edge: center)
    .top(to: anotherView, edge: .bottom, offset: 20)
```

#### `centerY(to:)`
```swift
    .centerY(to: anotherView) // Note: same as .center(in: anotherView, axis: .y)
    .centerY(to: anotherView, edge: .bottom)
    .centerY(to: anotherView, offset: 20)
```

#### `bottom(to:)`
```swift
    .bottom(to: anotherView)
    .bottom(to: .safeArea, edge: center)
    .bottom(to: anotherView, edge: .top, offset: -20)
```

#### `firstBaseline()`
```swift
    oneView.layout.firstBaseline(to: anotherView)
    oneView.layout.firstBaseline(to: anotherView, edge: .lastBaseline)
```

#### `lastBaseline()`
```swift
    oneView.layout.lastBaseline(to: anotherView)
    oneView.layout.lastBaseline(to: anotherView, edge: .firstBaseline)
```

#### `below()`
```swift
    oneView.layout.below(anotherView)
    oneView.layout.below(anotherView, offset: 10)
```

### Helpers
#### `stack`
```swift
    parentView.layout
        .stack([view1, view2, view3 view4], space: 10)
        
    parentView.layout
        .stack([view1, view2, view3 view4], space: 10, below: headerView, offset20)
```

#### `followedBy()`
```swift
    view1.layout
        .top(to: .safeArea) // view1.topAnchor = safeArea.topAnchor
        .followedBy(view2) // view2.topAnchor = view1.bottomAnchor
        .followedBy(view3, offset: 20) // view3.topAnchor = view2.bottomAnchor + 20
        .followedBy(view4, offset: 10) // view4.topAnchor = view3.bottomAnchor + 10
```

***

[<- Middle out parameters](middle-out-parameters)
