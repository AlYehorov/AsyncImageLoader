import SwiftUI

public struct AsyncImageView: View {
    @State private var uiImage: UIImage?
    let url: URL
    let placeholder: UIImage
    
    public init(url: URL, placeholder: UIImage) {
        self.url = url
        self.placeholder = placeholder
    }
    
    public var body: some View {
        Image(uiImage: uiImage ?? placeholder)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear {
                Task {
                    await loadImage()
                }
            }
    }
    
    private func loadImage() async {
        if let cachedImage = ImageCacheService.shared.getImage(forKey: url as NSURL) {
            self.uiImage = cachedImage
            return
        }
        
        do {
            if let image = try await NetworkService.shared.downloadImage(from: url) {
                ImageCacheService.shared.setImage(image, forKey: self.url as NSURL)
                self.uiImage = image
            }
        } catch {
            print("Error downloading image: \(error)")
        }
    }
}

