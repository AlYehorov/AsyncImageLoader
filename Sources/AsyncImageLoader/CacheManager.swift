
public class CacheManager {
    public static let shared = CacheManager()
    private init() {}
    
    public func invalidateCache() {
        ImageCacheService.shared.invalidateCache()
    }
}
