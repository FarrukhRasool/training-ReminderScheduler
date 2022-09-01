//
//  ReminderViewController+CellConfiguration.swift
//  ios-developer-uikit-project
//
//  Created by PakWheels on 01/09/2022.
//

import Foundation
import UIKit

extension ReminderViewController{
    
    func defaultConfiguration(for cell : UICollectionViewListCell, at row : Row) -> UIListContentConfiguration{
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        return contentConfiguration
        
    }
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String) -> UIListContentConfiguration {
        
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        return contentConfiguration
    
    }
    
    func titleConfiguration(for cell: UICollectionViewListCell, with title: String?) -> TextFieldContentView.Configuration {
            var contentConfiguration = cell.textFieldConfiguration()
            contentConfiguration.text = title
            return contentConfiguration
        }
    
    
    func text(for row: Row) -> String? {
      switch row {
      case .viewDate: return reminder.dueDate.dayText
      case .viewNotes: return reminder.notes
      case .viewTime: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
      case .viewTitle: return reminder.title
      default: return nil
      }
    }
    
    
}
