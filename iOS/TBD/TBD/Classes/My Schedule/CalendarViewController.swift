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
    
    @IBOutlet var appointments: [UIStackView]!
    
    @IBOutlet weak var sundayCell: RoundedShadowView!
    @IBOutlet weak var mondayCell: RoundedShadowView!
    
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (dailyExercices + progressiveRelaxations + morningWorkouts).forEach { $0.isHidden = true }
        sundayCell.isHidden = true
        mondayCell.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let appointmentViewController = segue.destination as! AppointmentViewController
        switch segue.identifier {
        case "consultation":
            appointmentViewController.appointmentNameString = "Dr. John Smith Consultation"
        case "medication":
            appointmentViewController.appointmentNameString = "Medication reminder: Predisone"
        case "recovery":
            appointmentViewController.appointmentNameString = "Recovery program"
        default:
            break
        }
    }
    
}

extension CalendarViewController: RoutinesViewControllerDelegate {
    func didChangeRoutines(_ selectionInfo: RoutinesViewController.RoutinesSelectionInfo) {
        dailyExercices.forEach { $0.isHidden = !selectionInfo.dailyExerciceSelected}
        progressiveRelaxations.forEach { $0.isHidden = !selectionInfo.progressiveRelaxationSelected}
        morningWorkouts.forEach { $0.isHidden = !selectionInfo.morningWorkoutsSelected}
        
        sundayCell.isHidden = true
        mondayCell.isHidden = true
        if selectionInfo.dailyExerciceSelected || selectionInfo.morningWorkoutsSelected {
            sundayCell.isHidden = false
        }
        
        if selectionInfo.dailyExerciceSelected || selectionInfo.progressiveRelaxationSelected {
            mondayCell.isHidden = false
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension CalendarViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = CGPoint.init(x: 0, y: self.view.frame.height)
        transition.circleColor = UIColor.white
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint =  CGPoint.init(x: 0, y: self.view.frame.height)
        transition.circleColor = UIColor.white
        
        return transition
    }
}

