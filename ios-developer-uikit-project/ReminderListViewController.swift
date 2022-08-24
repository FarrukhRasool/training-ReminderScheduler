//
//  ViewController.swift
//  UIKIT
//
//  Created by PakWheels on 18/08/2022.
//

import Foundation
import UIKit

class ReminderListViewController: UICollectionViewController {

    typealias DataSource=UICollectionViewDiffableDataSource<Int,String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    var dataSource:DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        collectionView.collectionViewLayout = listLayout()
            
        let cellRegistration = UICollectionView.CellRegistration { (cell: UICollectionViewListCell,
                                                                    indexPath: IndexPath,
                                                                    itemIdentifier: String) in
            let reminder = Reminder.sampleData[indexPath.item]
            var contentConfiguration = cell.defaultContentConfiguration()

            contentConfiguration.text=reminder.title
            cell.contentConfiguration=contentConfiguration
        }
                
       // let reminder=Reminder.sampleData[indexPath]
        // Do any additional setup after loading the view.
        
        
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
            var snapshot=Snapshot()
            snapshot.appendSections([0])
            snapshot.appendItems(Reminder.sampleData.map{$0.title})
            
            dataSource.apply(snapshot)
            collectionView.dataSource=dataSource
    }


    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listconfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listconfiguration.showsSeparators = false
        listconfiguration.backgroundColor = .clear
        
        return UICollectionViewCompositionalLayout.list(using: listconfiguration)
    }
    
}
