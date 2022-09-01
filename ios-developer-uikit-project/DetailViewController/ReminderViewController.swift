//
//  ReminderViewController.swift
//  ios-developer-uikit-project
//
//  Created by PakWheels on 30/08/2022.
//

import Foundation
import UIKit
class ReminderViewController :  UICollectionViewController{
    private typealias DataSource = UICollectionViewDiffableDataSource <Section, Row>
    private typealias SnapShot = NSDiffableDataSourceSnapshot <Section, Row>
    
    
    private var dataSource : DataSource!
    var reminder : Reminder
    
    init(reminder : Reminder) {
        
        self.reminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        listConfiguration.headerMode = .firstItemInSection
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
            
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        navigationItem.rightBarButtonItem = editButtonItem
                
            updateSnapshotForViewing()
    
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            updateSnapshotForEditing()
        }else{
            updateSnapshotForViewing()
        }
    }
        func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath:IndexPath, row: Row){
            
            let section = section (for : indexPath)
            switch(section, row){
            case (_, .header(let title)):
                        cell.contentConfiguration = headerConfiguration(for: cell, with: title)
            case(.view, _) : do {
                        cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
               // cell.tintColor = .todayPrimaryTint
            }
            default :
                fatalError("Unexpected combination of section and row.")
            }
            
            
            
            
        }
    
    func updateSnapshotForEditing(){
        var snapshot = SnapShot()
        
        snapshot.appendSections([.date , .title, .notes])
        
        snapshot.appendItems([.header(Section.title.name)], toSection: .title)
        snapshot.appendItems([.header(Section.date.name)], toSection: .date)
        snapshot.appendItems([.header(Section.notes.name)], toSection: .notes)
        
        dataSource.apply(snapshot)
        
        
    }
    
         func updateSnapshotForViewing(){
         
            var snapshot = SnapShot()
             snapshot.appendSections([.view])
             snapshot.appendItems([.viewTitle, .viewDate, .viewTime, .viewNotes], toSection: .view)
             snapshot.appendItems([.header(""), .viewTitle, .viewDate, .viewTime, .viewNotes], toSection: .view)
            dataSource.apply(snapshot)
            
            
        }
    private func section(for indexPath: IndexPath) -> Section {
            let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
            guard let section = Section(rawValue: sectionNumber) else {
                fatalError("Unable to find matching section")
            }
            return section
        }
        
       
    
        

}

