//
//  CalendarViewController.swift
//  TBD
//
//  Created by George Muntean on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet var dailyExercices: [UIStackView]!
    @IBOutlet var progressiveRelaxations: [UIStackView]!
    @IBOutlet var morningWorkouts: [UIStackView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (dailyExercices + progressiveRelaxations + morningWorkouts).forEach { $0.isHidden = true }
    }
}

extension CalendarViewController: RoutinesViewControllerDelegate {
    func didChangeRoutines(_ selectionInfo: RoutinesViewController.RoutinesSelectionInfo) {
        dailyExercices.forEach { $0.isHidden = !selectionInfo.dailyExerciceSelected}
        progressiveRelaxations.forEach { $0.isHidden = !selectionInfo.progressiveRelaxationSelected}
        morningWorkouts.forEach { $0.isHidden = !selectionInfo.morningWorkoutsSelected}
    }
}
