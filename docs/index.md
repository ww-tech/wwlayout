Easy to write auto layout constraints, with minimal extensions to standard namespaces.

## Feature Highlights
* Easy to use, concise, readable API
* Backwards-compatible (i.e. pre iOS 11) Safe Area constraints
* Tag constraints to easily switch between different layouts (coming soon)
* Automatic switching of size-class based constraints (coming soon)

## Introduction

Constraints are added to a view using the view's `layout` property, like so:

```swift
    myView.layout.width(400)
```

Multiple constraints are easily added by chaining calls:

```swift
    myView.layout.width(400).height(200)
```

A more complicated example:

```swift
    let container = UIView()
    let child = UIView()
    
    child.layout
      .fill(container, axis: .x, inset: 20)
      .center(in: container, axis: .y, priority: .high)
      .top(.lessOrEqual, to: container, offset: 100)
      .height(toWidth: 0.5)
```

## Documentation

[Constraining targets](constraining-targets)

[Middle out parameters](middle-out-parameters)

[Method Reference](method-reference)

### Migrating from other layout methods

[If you're coming from PureLayout...](from-purelayout)

[If you're coming from Apple's native constraints...](from-native-constraints)

## Contributing

Please read the [contributing guidelines](contributing-guidelines)

## Authors
* [Steven Grosmark](https://github.com/g-mark), steven.grosmark@weightwatchers.com
* WW iOS Team

## License
WWLayout is © copyright by WW International.

WWLayout is licensed under the [Apache-2.0 Open Source license](http://choosealicense.com/licenses/apache-2.0/).
