//
//  ViewController.swift
//  VKClient
//
//  Created by Демьян Горчаков on 26.12.2022.
//
import WebKit
import UIKit

class LoginVKController: UIViewController {
    
    let session = Session.shared
    
    var vc: FriendTableTableViewController?
    
    @IBOutlet weak var WKWebK: WKWebView!
    
    let userId = "8216514"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WKWebK.navigationDelegate = self
        
        var urlComponent = URLComponents()
        
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        
        urlComponent.queryItems = [
            URLQueryItem(name: "client_id", value: userId),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
        ]
        
        let url = urlComponent.url
        
        if UIApplication.shared.canOpenURL(url!) {
            let request = URLRequest(url: url!)
            WKWebK.load(request)
        }
    }
}
        
        extension LoginVKController: WKNavigationDelegate {
            
            func webView(_ webView: WKWebView,
                         decidePolicyFor navigationResponse: WKNavigationResponse,
                         decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
                
                guard let url = navigationResponse.response.url,
                       url.path == "/blank.html",
                      let fragment = url.fragment else {
                    decisionHandler(.allow)
                    return
                }
                
                let parms = fragment
                    .components(separatedBy: "&")
                    .map { $0.components(separatedBy: "=")}
                    .reduce([String: String]()) { result, parm in
                        var dict = result
                        let key = parm[0]
                        let value = parm[1]
                        dict[key] = value
                        return dict
                    }
                
                if let token = parms["access_token"] {
                    self.session.token = token
                    
                    vc = UIStoryboard(name: "Main", bundle:nil)
                        .instantiateViewController(withIdentifier:"FriendTableTableViewController") as? FriendTableTableViewController
                    
                    self.view.insertSubview((self.vc?.view)!, at: 9)
                }
                
                decisionHandler(.cancel)
                
            }
        }
