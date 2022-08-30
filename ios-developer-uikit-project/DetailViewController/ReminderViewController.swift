//
//  ReminderViewController.swift
//  ios-developer-uikit-project
//
//  Created by PakWheels on 30/08/2022.
//

import Foundation
import UIKit
class ReminderViewController :  UICollectionViewController{
    private typealias DataSource = UICollectionViewDiffableDataSource <Int, Row>
    
    private var dataSource : DataSource!
    var reminder : Reminder
    
    init(reminder : Reminder) {
        
        self.reminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(collectionViewLayout: listLayout)
    }
    
    
    
   
    
    
    required init?(coder: NSCoder) {
           fatalError("Always initialize ReminderViewController using init(reminder:)")
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
                   return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    
    
    
    }
        func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath:IndexPath, row: Row){
            
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = text (for: row)
            contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
            contentConfiguration.image = row.image
            cell.contentConfiguration = contentConfiguration
           // cell.tintColor = .todayPrimaryTint
            
        }
    
    
        func text(for row: Row) -> String? {
          switch row {
          case .viewDate: return reminder.dueDate.dayText
          case .viewNotes: return reminder.notes
          case .viewTime: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
          case .viewTitle: return reminder.title
          }
      }

    }
}
