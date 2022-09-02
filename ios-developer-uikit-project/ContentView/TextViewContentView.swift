//
//  TextViewContentView.swift
//  ios-developer-uikit-project
//
//  Created by PakWheels on 01/09/2022.
//

import Foundation
import UIKit

class TextViewContentView : UIView , UIContentView {
    var text : String? = ""
    struct Configuration : UIContentConfiguration{
        var text: String? = ""
        var onChange: (String)->Void = { _ in }


                func makeContentView() -> UIView & UIContentView {
                    return TextViewContentView(self)
                }
    }
    
    
    
       
    let textView = UITextView()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(textView, height: 200)
        textView.delegate = self
        textView.backgroundColor = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        textView.text = configuration.text
    }
}

extension UICollectionViewListCell {
    func textViewConfiguration() -> TextViewContentView.Configuration {
        TextViewContentView.Configuration()
    }

}

extension TextViewContentView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        guard let configuration = configuration as? TextViewContentView.Configuration else { return }
        configuration.onChange(textView.text)
        }
}
