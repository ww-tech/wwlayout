# Middle-out parameters
Each method for creating a constraint has a core set of parameters - e.g.:

```swift
    .size(100, 200) // width, height
    .left(to: otherView)
    .center(in: .safeArea)
    .fill(.superview)
```

### `priority`

All methods have a final optional `priority` parameter, which allows for setting the priority of a single constraint. Priorities by default are set to `.required`, but can be specified per constraint, like this:

```swift
    childView.layout
        .center(in: containerView, priority: .high)
        .below(headerView, prioriyty: .high)
        .size(200, 150, priority: .low - 1)
```

If a number of constraints need to be created with the same priority, then tell the layout instance to default to the desired priority, like this:

```swift
    childView.layout(priority: .high)
        .center(in: containerView)
        .below(headerView)
        .size(200, 150, priority: .low)
```

### `inset`, `offset`

For many constraints, you can also specify an `inset`, or an `offset`:

```swift
    .left(to: otherView, offset: 20)
    .fill(.superview, inset: 20)
```

The `inset` parameter can either be a single constant, a pair of width, height constants, or all four edges:

```swift
    // left, top, right, bottom all inset by 20pt
    .fill(.superview, inset: 20)
    
    // left & right inset by 20pt, top & bottom inset by 10pt
    .fill(.superview, inset: Insets(20, 10))
    
    // each edge explicitly specified
    .fill(.superview, inset: Insets(left: 10, top: 5, right: 20, bottom: 0))

    // each edge explicitly specified with UIEdgeInsets
    fill(.superview, inset: UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 20))
```

### `edge`

When constraining a single edge, the constraint (by default) is made with the same edge of the other view:

```swift
    // constrains leftAnchor of oneView to leftAnchor of anotherView
    oneView.layout.left(to: anotherView)
```

You can alternatively specify a different edge of the other view - so long as the edge is of the same axis:

```swift
    // constrains leftAnchor of oneView to rightAnchor of anotherView
    oneView.layout.left(to: anotherView, edge: .right)
    
    // constrains leftAnchor of oneView to centerXAnchor of anotherView
    oneView.layout.left(to: anotherView, edge: .center, offset: 10)
```

### `relation`
Most methods accept an initial relation parameter, which allows for <= and >= constraints:

```swift
    oneView.layout
        .width(.greaterOrEqual, to: anotherView)
        .width(.lessOrEqual, to: 500)
        .left(.greaterOrEqual, to: 20)
```

The `relation` optional parameter is always first.
Methods that can have an unlabelled constant as their first parameter, will add a `to:` label to their `constant` parameter when preceeded by a `relation`:

```swift
    .width(100)
    .width(.lessOrEqual, to: 100)
```

***

[<- Constraining targets](constraining-targets) | [Method reference ->](method-reference)
