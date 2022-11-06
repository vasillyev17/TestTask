//
//  Extensions.swift
//  NewsApp
//
//  Created by ihor on 04.11.2022.
//

import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(url: url as URL)
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {
                (response: URLResponse?, data: Data?, error: (any Error)?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData as Data)
                }
            }
        }
    }
}

extension UIFont {

    func withTraits(traits:UIFontDescriptor.SymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)) ?? UIFontDescriptor()
        return UIFont(descriptor: descriptor, size: 0)
    }

    func boldItalic() -> UIFont {
        return withTraits(traits: .traitBold, .traitItalic)
    }

}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

extension UINavigationController {

    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }

}
