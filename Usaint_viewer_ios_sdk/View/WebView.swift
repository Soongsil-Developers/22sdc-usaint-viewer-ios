import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    var urlToLoad: String
    
    public func makeUIView(context: Context) -> WKWebView {
        //unwrapping
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        
    }
}

//struct WebView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebView(urlToLoad: "https://www.naver.com")
//    }
//}

