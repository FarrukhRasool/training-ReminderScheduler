//
//  ReminderListViewController+Actions.swift
//  ios-developer-uikit-project
//
//  Created by PakWheels on 26/08/2022.
//

import Foundation
extension ReminderListViewController{
    @objc func didPressButton(_ sender:ReminderDoneButton){
       
    
        guard let id = sender.id else{ return }
        completeReminder(with: id)
        
        
        
    }
}
