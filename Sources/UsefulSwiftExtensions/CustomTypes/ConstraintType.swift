import UIKit

public enum ConstraintType {
    case leading(constant: CGFloat = 0), trailing(constant: CGFloat = 0),
         top(constant: CGFloat = 0), bottom(constant: CGFloat = 0)

    func constraint(_ view: UIView, toView: UIView) -> NSLayoutConstraint {
        switch self {
        case .leading(let constant):
                .init(item: view, attribute: .leading, relatedBy: .equal, toItem: toView, attribute: .leading,
                      multiplier: 1.0, constant: constant)
        case .trailing(let constant):
                .init(item: view, attribute: .trailing, relatedBy: .equal, toItem: toView, attribute: .trailing,
                      multiplier: 1.0, constant: constant)
        case .top(let constant):
                .init(item: view, attribute: .top, relatedBy: .equal, toItem: toView, attribute: .top,
                      multiplier: 1.0, constant: constant)
        case .bottom(let constant):
                .init(item: view, attribute: .bottom, relatedBy: .equal, toItem: toView, attribute: .bottom,
                      multiplier: 1.0, constant: constant)
        }
    }
}
