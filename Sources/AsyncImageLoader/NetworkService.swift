
import Foundation
import UIKit

public class NetworkService {
    public static let shared = NetworkService()
    
    private let urlSession: URLSession
    
    private init() {
        let cacheSizeMemory = 50 * 1024 * 1024
        let cacheSizeDisk = 200 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: cacheSizeMemory, diskCapacity: cacheSizeDisk, diskPath: nil)
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        config.urlCache = urlCache
        
        self.urlSession = URLSession(configuration: config)
    }
    
    public func downloadImage(from url: URL) async throws -> UIImage? {
        let (data, _) = try await urlSession.data(from: url)
        return UIImage(data: data)
    }
}
