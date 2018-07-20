//
//  PostContentViewController.swift
//  TBD
//
//  Created by Emanuel Jarnea on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

extension URL {
    static var documentsDirectoryURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

protocol PostContentViewControllerDelegate: class {
    func didCreatePost(item: FeedItemModel)
}

class PostContentViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var attachButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageContainer: UIView!
    let imageHeight: CGFloat = 200
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var testAreaContainer: UIView!
    
    var videoName: String?
    
    weak var delegate: PostContentViewControllerDelegate?
    
    func applyShadow(to view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.1
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textArea.text = nil
        applyShadow(to: testAreaContainer)
        applyShadow(to: imageContainer)
        imageView.image = nil
        imageViewHeight.constant = attachButtonHeight.constant
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
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
    
    func photoLibrary() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.mediaTypes = ["public.movie", "public.image"]
            present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func video() {
        VideoHelper.startMediaBrowser(delegate: self, sourceType: .camera)
    }
    
    
    @IBAction func addAttachment(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Record Video", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.video()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { (alert:UIAlertAction!) -> Void in
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
    
    @IBAction func didTapPostButton(_ sender: UIBarButtonItem) {
        
        if let delegate = delegate {
            
            var attachment: FeedItemModel.MediaType?
            
            var mediaType: FeedItemModel.MediaType?
            if let videoName = videoName {
                mediaType = FeedItemModel.MediaType.video(fileName: videoName, imageData: imageView.image!)
            } else if let imageData = imageView.image {
                mediaType = FeedItemModel.MediaType.image(imageData: imageData)
            }
            
            if let mediaType = mediaType {
                attachment = mediaType
            }
            
            let item = FeedItemModel(username: defaultUsername, avatarImage: #imageLiteral(resourceName: "user_icon"), text: textArea.text, attachment: attachment, reactions: 0, hoursAgo: 0, comments: [])
            
            delegate.didCreatePost(item: item)
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension PostContentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        videoName = nil
        print(info)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            imageViewHeight.constant = imageHeight
        } else if let videoURL = info[UIImagePickerControllerMediaURL] as? NSURL {
            imageView.image = VideoHelper.getVideoThumbnail(for: videoURL.path!)
            imageViewHeight.constant = imageHeight
            //save the video to the documents folder
            videoName = videoURL.pathComponents?.last
            print(videoName!)
            let documentsDirectoryURL = URL.documentsDirectoryURL
            let newVideoURL = documentsDirectoryURL.appendingPathComponent(videoName!)
            print(newVideoURL)
            try! FileManager.default.moveItem(at: videoURL as URL, to: newVideoURL)
        } else {
            print("Something went wrong")
        }
        dismiss(animated: true, completion: nil)
    }
}
