//
//  PostContentViewController.swift
//  TBD
//
//  Created by Emanuel Jarnea on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class PostContentViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var attachButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    let imageHeight: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textArea.text = nil
        imageView.image = nil
        imageViewHeight.constant = attachButtonHeight.constant
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        
//        textArea.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
//            self?.imageViewHeight.constant = self?.imageHeight ?? 0
//            self?.imageView.image = #imageLiteral(resourceName: "test")
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.imageViewBottomConstraint?.constant = 20
            } else {
                self.imageViewBottomConstraint?.constant = endFrame!.size.height + 20
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    func photoLibrary()
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func addAttachment(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func didTapOutsideKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func dismissScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension PostContentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            imageViewHeight.constant = imageHeight
        }else{
            print("Something went wrong")
        }
        dismiss(animated: true, completion: nil)
    }
}
