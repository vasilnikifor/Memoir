import UIKit

extension UITextView {
    
    // MARK: - Enums
    
    enum CursorPosition {
        case start
        case end
    }
    
    // MARK: - Methods
    
    func setCursor(to cursorPosition: CursorPosition) {
        var newPosition: UITextPosition!
          
        switch cursorPosition {
        case .start:
            newPosition = self.beginningOfDocument
        case .end:
            newPosition = self.endOfDocument
        }
        
        self.selectedTextRange = self.textRange(from: newPosition, to: newPosition)
    }
    
}
