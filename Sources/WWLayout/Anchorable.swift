//
// ===----------------------------------------------------------------------===//
//
//  Anchorable.swift
//
//  Created by Steven Grosmark on 11/29/17.
//  Copyright © 2018 WW International, Inc.
//
//
//  This source file is part of the WWLayout open source project
//
//     https://github.com/ww-tech/wwlayout
//
//  Copyright © 2017-2021 WW International, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
// ===----------------------------------------------------------------------===//
//

import UIKit

/// Something that can be constrained to (i.e. a view, a layout guide, or something like "the superview")
public protocol Anchorable {
    
    /// Get the Y axis LayoutAnchor for an edge
    func anchor(_ edge: LayoutYEdge) -> LayoutYAnchor
    
    /// Get the X axis LayoutAnchor for an edge
    func anchor(_ edge: LayoutXEdge) -> LayoutXAnchor
    
    /// Get the width/height LayoutAnchor for an edge
    func anchor(_ dimension: LayoutDimensionEdge) -> LayoutDimensionAnchor
}

extension UIView: Anchorable { }
extension UILayoutGuide: Anchorable { }

extension Anchorable {
    
    /// Get the Y axis LayoutAnchor for an edge
    public func anchor(_ edge: LayoutYEdge) -> LayoutYAnchor {
        switch edge {
        case .top: return LayoutYAnchor(item: self, attribute: .top)
        case .bottom: return LayoutYAnchor(item: self, attribute: .bottom)
        case .center: return LayoutYAnchor(item: self, attribute: .centerY)
        case .firstBaseline: return LayoutYAnchor(item: self, attribute: .firstBaseline)
        case .lastBaseline: return LayoutYAnchor(item: self, attribute: .lastBaseline)
        }
    }
    
    /// Get the X axis LayoutAnchor for an edge
    public func anchor(_ edge: LayoutXEdge) -> LayoutXAnchor {
        switch edge {
        case .left: return LayoutXAnchor(item: self, attribute: .left)
        case .right: return LayoutXAnchor(item: self, attribute: .right)
        case .leading: return LayoutXAnchor(item: self, attribute: .leading)
        case .trailing: return LayoutXAnchor(item: self, attribute: .trailing)
        case .center: return LayoutXAnchor(item: self, attribute: .centerX)
        }
    }
    
    /// Get the width/height LayoutAnchor for an edge
    public func anchor(_ dimension: LayoutDimensionEdge) -> LayoutDimensionAnchor {
        switch dimension {
        case .width: return LayoutDimensionAnchor(item: self, attribute: .width)
        case .height: return LayoutDimensionAnchor(item: self, attribute: .height)
        }
    }
}

/// An Anchorable that may either be implied, calculated, or emulated.
public enum SpecialAnchorable {
    
    /// Anchor to the view's parent view
    case superview
    
    /// Anchor to the parent view's layoutMarginsGuide
    case margins
    
    /// Anchor to the parent view's safeAreaGuide
    /// Note: pre-iOS 11, this will fall back to .superview for the left and right edges,
    /// and the containing UIViewController's topLayoutGuide and bottomLayoutGuide
    case safeArea
    
    func anchorable(with view: UIView) -> Anchorable {
        guard let superview = view.superview else {
            fatalError("view does not have a superview")
        }
        
        switch self {
        
        case .superview:
            return superview
        
        case .margins:
            // constraining a view to margins means constraining it to it's superview's layoutMarginsGuide
            if superview.next == nil {
                print("WARNING: using .margins, but view hasn't been added to the view hierarchy yet - layout will fail pre iOS 11")
            }
            return superview.layoutMarginsGuide
        
        case .safeArea:
            // constraining a view to safeArea means constraining it to it's superview's safeAreaLayoutGuide
            if #available(iOS 11.0, *), #available(tvOS 11.0, *) {
                return superview.safeAreaLayoutGuide
            }
            // fall back to the superview left/right, and the controller's top/bottom layout guides
            return EmulatedSafeAreaAnchorable(for: superview)
        }
    }
}

/// An Anchorable that emulates iOS 11's safe area, pre-iOS 11,
/// By mapping top & bottom anchors to the containing UIViewController's top/bottomLayoutGuide
public struct EmulatedSafeAreaAnchorable: Anchorable {
    private let view: UIView
    private let controller: UIViewController?
    
    init(for view: UIView) {
        self.view = view
        self.controller = EmulatedSafeAreaAnchorable.viewController(for: view)
    }
    
    private static func viewController(for view: UIView) -> UIViewController? {
        var responder: UIResponder? = view
        repeat {
            responder = responder?.next
            if let vc = responder as? UIViewController {
                return vc
            }
        } while responder != nil
        return nil
    }
    
    /// Get the Y axis LayoutAnchor for an edge
    public func anchor(_ edge: LayoutYEdge) -> LayoutYAnchor {
        switch edge {
        case .top:
            if #available(iOS 11.0, *) { }
            else {
                if let anchor = controller?.topLayoutGuide {
                    return LayoutYAnchor(item: anchor, attribute: .bottom)
                }
            }
            return LayoutYAnchor(item: view, attribute: .top)
        case .bottom:
            if #available(iOS 11.0, *) { }
            else {
                if let anchor = controller?.bottomLayoutGuide {
                    return LayoutYAnchor(item: anchor, attribute: .top)
                }
            }
            return LayoutYAnchor(item: view, attribute: .bottom)
        case .center: return LayoutYAnchor(item: view, attribute: .centerY)
        case .firstBaseline: return LayoutYAnchor(item: view, attribute: .firstBaseline)
        case .lastBaseline: return LayoutYAnchor(item: view, attribute: .lastBaseline)
        }
    }
    
    /// Get the X axis LayoutAnchor for an edge
    public func anchor(_ edge: LayoutXEdge) -> LayoutXAnchor {
        switch edge {
        case .left: return LayoutXAnchor(item: view, attribute: .left)
        case .right: return LayoutXAnchor(item: view, attribute: .right)
        case .leading: return LayoutXAnchor(item: view, attribute: .leading)
        case .trailing: return LayoutXAnchor(item: view, attribute: .trailing)
        case .center: return LayoutXAnchor(item: view, attribute: .centerX)
        }
    }
    
    /// Get the width/height LayoutAnchor for an edge
    public func anchor(_ dimension: LayoutDimensionEdge) -> LayoutDimensionAnchor {
        switch dimension {
        case .width: return LayoutDimensionAnchor(item: view, attribute: .width)
        case .height: return LayoutDimensionAnchor(item: view, attribute: .height)
        }
    }
}
