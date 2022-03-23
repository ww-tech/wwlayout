<p align="center">
    <img src="logo.png" width="256" max-width="50%" alt="WWLayout" />
</p>
<h1 align="center">WWLayout</h1>
<p align="center">
    <!--
    <img src="https://circleci.com/gh/ww-tech/wwlayout/tree/develop.svg?style=shield" />
    <a href="https://codeclimate.com/repos/5bd1ca9c535ea53834001d51/maintainability"><img src="https://api.codeclimate.com/v1/badges/d42334bce58294611b8b/maintainability" /></a>
    <a href="https://codeclimate.com/repos/5bd1ca9c535ea53834001d51/test_coverage"><img src="https://api.codeclimate.com/v1/badges/d42334bce58294611b8b/test_coverage" /></a>
    -->
    <img src="https://img.shields.io/badge/Swift-4.0%20--%205.6-blueviolet.svg?style=flat" />
    <img src="https://img.shields.io/badge/iOS-10.3%20--%2015.x-blue.svg?style=flat" />
</p>

Easy to write auto layout constraints, with minimal extensions to standard namespaces.

## Feature Highlights
* Easy to use, readable API
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

    container.layout.fill(.safeArea)

    child.layout
      .fill(container, axis: .x, inset: 20)
      .center(in: container, axis: .y, priority: .high)
      .top(.lessOrEqual, to: container, offset: 100)
      .height(toWidth: 0.5)
```

## Dcumentation

### [Documentation can be found here](//ww-tech.github.io/wwlayout/)


## Installation

### Swift Package Manager

The WWLayout Package URL is:

```
https://github.com/ww-tech/wwlayout.git
```

Add the package dependency to your Xcode project using the `File` -> `Swift Packages` -> `Add Package Dependency...` menu item.

### Cocoapods

Simply add WWLayout to your `Podfile`:

```
  pod 'WWLayout'
```

## Contributing

## Authors
* [Steven Grosmark](https://github.com/g-mark), steven.grosmark@ww.com
* WW iOS Team

## License
WWLayout is © copyright by WW International.

WWLayout is licensed under the [Apache-2.0 Open Source license](http://choosealicense.com/licenses/apache-2.0/).
