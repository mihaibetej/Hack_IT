/// Copyright (c) 2018 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import MobileCoreServices
import AVFoundation

class VideoHelper {
    
    static func startMediaBrowser(delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate, sourceType: UIImagePickerControllerSourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = sourceType
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        delegate.present(mediaUI, animated: true, completion: nil)
    }
    
    static func orientation(for asset: AVAsset) -> UIInterfaceOrientation {
        let videoTrack = asset.tracks(withMediaType: .video)[0]
        let size = videoTrack.naturalSize
        let txf = videoTrack.preferredTransform
        
        if (size.width == txf.tx && size.height == txf.ty) {
            return .landscapeRight
        } else if (txf.tx == 0 && txf.ty == 0) {
            return .landscapeLeft
        } else if (txf.tx == 0 && txf.ty == size.width) {
            return .portraitUpsideDown;
        } else {
            return .portrait;
        }
        
    }

    static func getVideoThumbnail(for path: String) -> UIImage {
        let asset = AVURLAsset(url: URL(fileURLWithPath: path), options: nil)
        let orientation = self.orientation(for: asset)
        
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        let cgImage =  try! imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
        
        switch orientation {
        case .landscapeLeft:
            return UIImage(cgImage: cgImage)
        case .landscapeRight:
            return UIImage(cgImage: cgImage, scale: 1.0, orientation: .down)
        case .portrait:
            return UIImage(cgImage: cgImage, scale: 1.0, orientation: .right)
        case .portraitUpsideDown:
            return UIImage(cgImage: cgImage, scale: 1.0, orientation: .left)
        case .unknown:
            preconditionFailure()
        }
    }
    
}
