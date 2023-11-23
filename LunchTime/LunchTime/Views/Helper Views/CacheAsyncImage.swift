//
//  CacheAsyncImage.swift
//  LunchTime
//
//  Created by Devin Eror on 11/17/23.
//

import SwiftUI



struct CacheAsyncImage<Content>: View where Content: View {
    private let url: URL?
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    let networkService = NetworkService.shared
    
    init(ref: String?,
         width: Int?,
         url: URL? = nil,
         scale: CGFloat = 1.0,
         transaction: Transaction = Transaction(),
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        
        if let ref = ref,
           let width = width {
            self.url = networkService.photoURL(
                photoReference: ref,
                maxWidth: width)
        } else {
            self.url = url
        }
        
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        if let url = url {
            if let cached = ImageCache[url] {
                content(.success(cached))
            } else {
                AsyncImage(
                    url: url,
                    scale: scale,
                    transaction: transaction) { phase in
                        cacheImage(phase: phase, url: url)
                    }
            }
        } else {
            content(.failure(LTError.invalidURL))
            
        }
    }
    
    func cacheImage(phase: AsyncImagePhase, url: URL) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        
        return content(phase)
    }
}



// TODO: setup caching
class ImageCache {
    static private var cache: [URL: Image] = [:]

    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}



#Preview {
    CacheAsyncImage(ref: "",
                    width: 0,
                    url: URL(string: "https://picsum.photos/200")!) { phase in
        switch phase {
        case .empty:
            ProgressView()
        case .success(let image):
            image
        case .failure(_):
            ProgressView()
        @unknown default:
            fatalError()
        }
    }
}
