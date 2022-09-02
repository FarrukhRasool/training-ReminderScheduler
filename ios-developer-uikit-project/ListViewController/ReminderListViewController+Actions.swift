//
//  ReminderListViewController+Actions.swift
//  ios-developer-uikit-project
//
//  Created by PakWheels on 26/08/2022.
//

import Foundation
import UIKit
extension ReminderListViewController{
    @objc func didPressButton(_ sender : ReminderDoneButton){
       
    
        guard let id = sender.id else{ return }
        completeReminder(with: id)
        
        
        
    }
    
    @objc func didCancelAdd(_ sender: UIBarButtonItem) {
            dismiss(animated: true)
        }
    
    
    @objc func didPressAddButton(_ sender: UIBarButtonItem) {
          let reminder = Reminder(title: "", dueDate: Date.now)
          let viewController = ReminderViewController(reminder: reminder) { [weak self] reminder in
              self?.add(reminder)
              self?.updateSnapshot()
              self?.dismiss(animated: true)
          }
          viewController.isAddingNewReminder = true
          viewController.setEditing(true, animated: false)
          viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelAdd(_:)))
          viewController.navigationItem.title = NSLocalizedString("Add Reminder", comment: "Add Reminder view controller title")
          let navigationController = UINavigationController(rootViewController: viewController)
          present(navigationController, animated: true)
      }
}

