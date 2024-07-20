import SwiftUI

extension View {
    
    /// This function adds the ability to toggle a views visibility
    /// - Parameter shouldHide: flag to indicate weather it is hidden or not
    /// - Returns: retruns the view with added function
    @ViewBuilder public func hide(_ shouldHide: Bool) -> some View {
        self.opacity(shouldHide ? 0 : 1)
    }
}
