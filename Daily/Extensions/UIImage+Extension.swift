import UIKit

extension UIImage {
    func getCompressedData(to sizeInMb: Int = 1) -> Data? {
        let requiredSizeInBytes = Int(sizeInMb * 1024 * 1024)
        let compressionsQuality: [CGFloat] = [1, 0.75, 0.5, 0.25, 0.1, 0]
        
        for compressionQualityItem in compressionsQuality {
            guard let currentData = jpegData(compressionQuality: compressionQualityItem) else {
                return nil
            }
            
            if currentData.count <= requiredSizeInBytes || compressionQualityItem == compressionsQuality.last {
                return currentData
            }
        }
        
        return nil
    }
}
