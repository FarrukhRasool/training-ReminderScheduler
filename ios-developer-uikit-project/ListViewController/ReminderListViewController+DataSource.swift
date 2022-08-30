//
//  ReminderListViewController+DataSource.swift
//  ios-developer-uikit-project
//
//  Created by PakWheels on 25/08/2022.
//

import Foundation
import UIKit

extension ReminderListViewController{
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int,Reminder.ID>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int,Reminder.ID>
    
    
    var ReminderCompletedValue:String{
        
        NSLocalizedString("Completed", comment: "Reminder Completed value")
    }
    var reminderNotCompletedValue:String{
        NSLocalizedString("Not Completed",comment: "Reminder not completed value")
    }
    
    func updateSnapshot(reloading ids: [Reminder.ID] = []) {
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        snapshot.appendItems( reminders.map{ $0.id })
        if !ids.isEmpty{
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
        
        }
    
    func cellRegisterationHandler(cell:UICollectionViewListCell,indexPath:IndexPath,id:Reminder.ID){
        let reminder = reminders[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration=contentConfiguration
        
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        // doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessibilityCustomActions = [ doneButtonAccessibilityAction(for: reminder) ]
        cell.accessibilityValue = reminder.isComplete ? ReminderCompletedValue : reminderNotCompletedValue
        cell.accessories = [ .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always) ]
        

        
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
               // backgroundConfiguration.backgroundColor = .todayListCellBackground
                cell.backgroundConfiguration = backgroundConfiguration
    }
    

    private func doneButtonConfiguration(for reminder:Reminder)->UICellAccessory.CustomViewConfiguration{
        let symbolName=reminder.isComplete ? "circle.fill" :"circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName,withConfiguration: symbolConfiguration)
        let button = ReminderDoneButton()
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didPressButton(_:)), for: .touchUpInside)
        button.id = reminder.id
        
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
     }
    func reminder(for id : Reminder.ID) -> Reminder{
        
        let index=reminders.indexOfReminder(with: id)
        return reminders[index]
        
    }
    func update(_ reminder: Reminder, with id : Reminder.ID){
        let index=reminders.indexOfReminder(with: id)
        reminders[index]=reminder
    }
    
    
    func completeReminder(with id:Reminder.ID){
        var reminder = reminder(for: id)
        reminder.isComplete.toggle()
        update(reminder, with: id)
        updateSnapshot(reloading: [id])
        
    }
    
    
}
