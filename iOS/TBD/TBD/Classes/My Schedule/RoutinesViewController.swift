//
//  RoutinesViewController.swift
//  TBD
//
//  Created by George Muntean on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

protocol RoutinesViewControllerDelegate {
    func didChangeRoutines(_ selectionInfo: RoutinesViewController.RoutinesSelectionInfo)
}

class RoutinesViewController: UIViewController {
    
    @IBOutlet var routinesButtons: [UIButton]!
    
    struct RoutinesSelectionInfo {
        let dailyExerciceSelected: Bool
        let progressiveRelaxationSelected: Bool
        let morningWorkoutsSelected: Bool
    }
    
    var delegate: RoutinesViewControllerDelegate?
    
    
    @IBAction func didTouchAddButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isUserInteractionEnabled = false
            sender.isEnabled  = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                sender.isUserInteractionEnabled = true
                sender.isEnabled = true
                sender.isSelected = true
            }
        }
        updateSelection()
    }
    private func isRoutineAdded(button: UIButton) -> Bool {
        return button.isSelected || !button.isEnabled
    }
    
    private func updateSelection() {
        let selectionInfo = RoutinesSelectionInfo(dailyExerciceSelected: isRoutineAdded(button: routinesButtons[0]),
                                                  progressiveRelaxationSelected: isRoutineAdded(button: routinesButtons[1]),
                                                  morningWorkoutsSelected: isRoutineAdded(button: routinesButtons[2]))
        delegate?.didChangeRoutines(selectionInfo)
    }
}
