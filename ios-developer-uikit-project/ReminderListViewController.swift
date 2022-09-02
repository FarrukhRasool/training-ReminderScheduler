//
//  ViewController.swift
//  UIKIT
//
//  Created by PakWheels on 18/08/2022.
//

import Foundation
import UIKit

class ReminderListViewController: UICollectionViewController {
    
    var dataSource: DataSource!
    var reminders: [Reminder] = Reminder.sampleData
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegisterationHandler)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
        addButton.accessibilityLabel = NSLocalizedString("Add reminder", comment: "Add button accessibility label")
        navigationItem.rightBarButtonItem = addButton
                        
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
            
        updateSnapshot()
        self.collectionView.dataSource=dataSource
    }

    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = reminders[indexPath.item].id
        showDetail(for: id)
        return false
    }

    func showDetail(for id: Reminder.ID) {
        let reminder = reminder(for: id)
        let viewController = ReminderViewController(reminder: reminder) { [weak self] reminder in
            self?.update(reminder, with: reminder.id)
            self?.updateSnapshot(reloading: [reminder.id])
            
        }
    
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    

    private func listLayout() -> UICollectionViewCompositionalLayout {
        
        var listconfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listconfiguration.showsSeparators = false
        listconfiguration.backgroundColor = .clear
        listconfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        
        return UICollectionViewCompositionalLayout.list(using: listconfiguration)
    }
    
    public func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction {
        let name = NSLocalizedString("Toggle completion", comment: "Reminder done button accessibility label")
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            return true
        }
        
        return action
    }
    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
            guard let indexPath = indexPath, let id = dataSource.itemIdentifier(for: indexPath) else { return nil }
            let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
            let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) { [weak self] _, _, completion in
                self?.deleteReminder(with: id)
                self?.updateSnapshot()
                completion(false)
            }
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
}
