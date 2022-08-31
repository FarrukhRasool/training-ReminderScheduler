//
//  ReminderViewController+Section.swift
//  ios-developer-uikit-project
//
//  Created by PakWheels on 31/08/2022.
//

import Foundation

extension ReminderViewController {
    enum Section : Int , Hashable {
                
                case view
                case title
                case date
                case notes
        
        
        var name : String{
            switch self{
            case .view : return ""
            case .title :
                return NSLocalizedString("Title", comment: "Tile section name")
            case .date :
                return NSLocalizedString("Date", comment: "Date section name")
            case .notes :
                return NSLocalizedString("Note", comment: "Note section name")
                
                
                
            }
                
        }
        
    }
}
