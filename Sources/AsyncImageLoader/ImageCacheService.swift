import Foundation
import UIKit

class ImageCacheService {
    static let shared = ImageCacheService()
    private init() {}
    
    private var cache = NSCache<NSURL, CacheItem>()
    
    private class CacheItem {
        let image: UIImage
        let expirationDate: Date
        
        init(image: UIImage, expirationDate: Date) {
            self.image = image
            self.expirationDate = expirationDate
        }
    }
    
    func getImage(forKey key: NSURL) -> UIImage? {
        guard let cacheItem = cache.object(forKey: key) else {
            return nil
        }
        
        if cacheItem.expirationDate > Date() {
            return cacheItem.image
        } else {
            cache.removeObject(forKey: key)
            return nil
        }
    }
    
    func setImage(_ image: UIImage, forKey key: NSURL, expiration: TimeInterval = 4 * 60 * 60) {
        let expirationDate = Date().addingTimeInterval(expiration)
        let cacheItem = CacheItem(image: image, expirationDate: expirationDate)
        cache.setObject(cacheItem, forKey: key)
    }
    
    func invalidateCache() {
        cache.removeAllObjects()
    }
}
