//
//  File.swift
//
//
//  Created by Anderson F Carvalho on 16/03/20.
//

#if os(iOS)
import UIKit

enum NSLayoutEnum {
    case top,
    bottom,
    leading,
    trailing
}

/**
 This extension set the constraints to the objects in the view
 
 The function *addSubview* is mandatory
 
 ### EXAMPLE ###
 ````
 let view = UIView()
 view.browseAddSubviews([myView])
 ````
 */

public extension UIView {
    
    /// This function add the subviews and set the *translatesAutoresizingMaskIntoConstraints*
    @discardableResult
    func browseAddSubviews(_ views: [UIView]) -> Self {
        for view in views {
            view.autoResizingOff()
            addSubview(view)
        }
        return self
    }

    @discardableResult
    private func autoResizingOff() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    ///This function add all margins to the super view margin
    @discardableResult
    func browseEdgeToSuperView(_ padding: UIEdgeInsets = .zero) -> Self {
        browseLeadingToSuperview(margin: padding.left)
        browseTopToSuperview(margin: padding.top)
        browseTrailingToSuperview(margin: padding.right)
        browseBottomToSuperview(margin: padding.bottom, isSafeLayout: true)
        return self
    }
    
    ///This function set the browseAspectRation
    @discardableResult
    func browseAspectRation(_ multiplier: CGFloat) -> Self {
        NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: multiplier, constant: 0).isActive = true
        return self
    }
    
    ///This function set the size like the *view* passed in the parameter
    @discardableResult
    func browseAnchorSize(to view: UIView) -> Self {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        return self
    }
    
    ///This function set the constraint leading to super view leading
    @discardableResult
    func browseLeadingToSuperview(margin: CGFloat = 0.0) -> Self {
        guard let superView = superview else { return self}
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: margin).isActive = true
        return self
    }
    
    ///This function set the constraint top to super view top
    @discardableResult
    func browseTopToSuperview(margin: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = .equal) -> Self {
        guard let superView = superview else { return self }
        layoutYConstraint(fromElement: topAnchor, toElement: superView.topAnchor, relation: relation, constant: margin)
        return self
    }
    
    ///This function set the constraint trailing to super view trailing
    @discardableResult
    func browseTrailingToSuperview(margin: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = .equal) -> Self {
        guard let superView = superview else { return self }
        layoutXConstraint(fromElement: trailingAnchor, toElement: superView.trailingAnchor, relation: relation, constant: -margin)
        return self
    }
    
    ///This function set the constraint bottom to super view bottom
    @discardableResult
    func browseBottomToSuperview(margin: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = .equal, isSafeLayout: Bool = false) -> Self {
        guard let superView = superview else { return self }
        layoutYConstraint(fromElement: bottomAnchor, toElement: isSafeLayout ? superView.safeAreaLayoutGuide.bottomAnchor : superView.bottomAnchor, relation: relation, constant: -margin)
        return self
    }
    
    ///This function set the constraint trailing to the element view leading passed in the parameter
    @discardableResult
    func browseTrailingToLeading(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, margin: CGFloat = 0.0) -> Self {
        layoutXConstraint(fromElement: trailingAnchor, toElement: element.leadingAnchor, relation: relation, constant: margin)
        return self
    }
    
    
    ///This function set the constraint leading to the element leading passed in the parameter
    @discardableResult
    func browseLeadingToLeading(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, margin: CGFloat = 0.0) -> Self {
        layoutXConstraint(fromElement: leadingAnchor, toElement: element.leadingAnchor, relation: relation, constant: margin)
        return self
    }
    
    ///This function set the constraint leading to the constraint trailing of the element passed in the parameter
    @discardableResult
    func browseLeadingToTrailing(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, margin: CGFloat = 0.0) -> Self {
        layoutXConstraint(fromElement: leadingAnchor, toElement: element.trailingAnchor, relation: relation, constant: margin)
        return self
    }
    
    ///This function set the constraint top to the constraint top of the element passed in the parameter
    @discardableResult
    func browseTopToTop(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, margin: CGFloat = 0.0) -> Self {
        topTo(nsLayout: .top, of: element, relation: relation, margin: margin)
        return self
    }
    
    ///This function set the constraint top to the constraint bottom of the element passed in the parameter
    @discardableResult
    func browseTopToBottom(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, margin: CGFloat = 0.0) -> Self {
        topTo(nsLayout: .bottom, of: element, relation: relation, margin: margin)
        return self
    }
    
    ///This function set the constraint trailing to the constraint trailing of the element passed in the parameter
    @discardableResult
    func browseTrailingToTrailing(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, margin: CGFloat = 0.0) -> Self {
        layoutXConstraint(fromElement: trailingAnchor, toElement: element.trailingAnchor, relation: relation, constant: -margin)
        return self
    }
    
    ///This function set the constraint bottom to the constraint bottom  of the element passed in the parameter
    @discardableResult
    func browseBottomToBotton(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, margin: CGFloat = 0.0) -> Self {
        layoutYConstraint(fromElement: bottomAnchor, toElement: element.bottomAnchor, relation: relation, constant: -margin)
        return self
    }
    
    ///This function set the constraint height
    @discardableResult
    func browseHeight(_ height: CGFloat, relation: NSLayoutConstraint.Relation = .equal) -> Self {
        if height != 0 {
            if relation == .equal {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            } else if relation == .greaterThanOrEqual {
                heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
            } else {
                heightAnchor.constraint(lessThanOrEqualToConstant: height).isActive = true
            }
        }
        return self
    }
    
    ///This function set the constraint width
    @discardableResult
    func browseWidth(_ width: CGFloat, relation: NSLayoutConstraint.Relation = .equal) -> Self {
        if width != 0 {
            if relation == .equal {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            } else if relation == .greaterThanOrEqual {
                widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
            } else {
                widthAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
            }
            
        }
        return self
    }
    
    ///This function set the constraint width equal to the constraint width passed in the parameter
    @discardableResult
    func browseWidthEqual(of element: UIView, multiplier: CGFloat = 1.0) -> Self {
        widthAnchor.constraint(equalTo: element.widthAnchor, multiplier: multiplier).isActive = true
        return self
    }
    
    ///This function set the constraint centerY to the center of the element passed in the parameter
    @discardableResult
    func browseCenterY(of element: UIView) -> Self {
        centerYAnchor.constraint(equalTo: element.centerYAnchor, constant: 0.0).isActive = true
        return self
    }
    
    ///This function set the constraint centerX to the center of the element passed in the parameter
    @discardableResult
    func browseCenterX(of element: UIView) -> Self {
        centerXAnchor.constraint(equalTo: element.centerXAnchor, constant: 0.0).isActive = true
        return self
    }
    
    @discardableResult
    private func layoutYConstraint(fromElement: NSLayoutYAxisAnchor, toElement: NSLayoutYAxisAnchor, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> Self {
        if relation == .equal {
            fromElement.constraint(equalTo: toElement, constant: constant).isActive = true
        } else if relation == .greaterThanOrEqual {
            fromElement.constraint(greaterThanOrEqualTo: toElement, constant: constant).isActive = true
        } else {
            fromElement.constraint(lessThanOrEqualTo: toElement, constant: constant).isActive = true
        }
        
        return self
    }
    
    @discardableResult
    private func layoutXConstraint(fromElement: NSLayoutXAxisAnchor, toElement: NSLayoutXAxisAnchor, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> Self {
        if relation == .equal {
            fromElement.constraint(equalTo: toElement, constant: constant).isActive = true
        } else if relation == .greaterThanOrEqual {
            fromElement.constraint(greaterThanOrEqualTo: toElement, constant: constant).isActive = true
        } else {
            fromElement.constraint(lessThanOrEqualTo: toElement, constant: constant).isActive = true
        }
        
        return self
    }
    
    @discardableResult
    private func topTo(nsLayout: NSLayoutEnum, of element: UIView, relation: NSLayoutConstraint.Relation = .equal, margin: CGFloat = 0.0) -> Self {
        if nsLayout == .top {
            topAnchor.constraint(equalTo: element.topAnchor, constant: margin).isActive = true
        } else {
            layoutYConstraint(fromElement: topAnchor, toElement: element.bottomAnchor, relation: relation, constant: margin)
        }
        
        return self
    }
}
#endif
