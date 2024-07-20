import UIKit

public extension UIView {
    func addSubView(_ view: UIView, with constraints: [ConstraintType] = []) {
        self.addSubview(view)
        constraints.forEach({
            $0.constraint(self, toView: view).isActive = true
        })
    }
}
