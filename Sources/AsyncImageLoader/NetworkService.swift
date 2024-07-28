
import Foundation
import UIKit

public class NetworkService {
    public static let shared = NetworkService()
    private init() {}
    
    public func downloadImage(from url: URL) async throws -> UIImage? {
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    }
}
