//
//  ReminderViewController+Row.swift
//  ios-developer-uikit-project
//
//  Created by PakWheels on 30/08/2022.
//

import Foundation
import UIKit
extension ReminderViewController{
    enum Row: Hashable {
           case header(String)
           case viewDate
           case viewNotes
           case viewTime
           case viewTitle
         
        var imageName : String?{
            
            switch self {
                        case .viewDate: return "calendar.circle"
                        case .viewNotes: return "square.and.pencil"
                        case .viewTime: return "clock"
                        default: return nil
                        }
            
            
        }
        
        var image : UIImage? {
                    guard let imageName = imageName else { return nil }
                    let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
                    return UIImage(systemName: imageName, withConfiguration: configuration)
                }
        
        
        var textStyle : UIFont.TextStyle {
                    switch self {
                    case .viewTitle: return .headline
                    default: return .subheadline
                    }
        
        
       }
    
    
    }
    
    
    
}
