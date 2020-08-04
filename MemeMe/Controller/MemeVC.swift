//
//  MemeVC.swift
//  MemeMe
//
//  Created by Abdualziz Aljuaid on 12/04/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class MemeVC: UIViewController {

    
    //MARK:- Outlets
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memesToolbar: UIToolbar!
    

    
    
    //MARK:- LLifecycle methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        shareButton.isEnabled = false
        memesToolbar.isHidden = false
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        setTextField(tf: topTextField, text: "TOP")
        setTextField(tf: bottomTextField, text: "BOTTOM")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    
    //MARK:- SetupTextFields
    func setTextField(tf: UITextField, text: String){
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 44)!,
            NSAttributedString.Key.strokeWidth:  -4.0
        ]
        tf.defaultTextAttributes = memeTextAttributes
        tf.autocapitalizationType = .allCharacters
        tf.textAlignment = .center
        tf.text = text
        tf.delegate = self
    }
    
    
    
    //MARK:- Save Meme
    func save(){
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: mainImage.image!, memedImage: generateMemedImage())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    
    
    //MARK:- GenerateMemedImage
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        navigationController?.isToolbarHidden = false
        navigationController?.isNavigationBarHidden = false
      
        return memedImage
    }
    
    
    
    
    
    
    //MARK:- Pick an Image
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        chooseImageFromCameraOrPhoto(source: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: UIBarButtonItem) {
        chooseImageFromCameraOrPhoto(source: .camera)
    }
    
    func chooseImageFromCameraOrPhoto(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
        shareButton.isEnabled = true
        memesToolbar.isHidden = true
    }
    
    
    
    
    //MARK:- Share Button
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        let memeImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                print("error")
                return
            }
            self.save()
        }

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    
    //MARK:- Cancel Button
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //MARK:- ShiftingViewController
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}











//MARK:- ImageViewDelegate
extension MemeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            mainImage.image = image
            dismiss(animated: true, completion: nil)
        }
    }
    
    
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}













//MARK:- TextFieldDelegate
extension MemeVC: UITextFieldDelegate{
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == topTextField {
            topTextField.text = ""
        }
        else if textField == bottomTextField {
            bottomTextField.text = ""
        }
    }
}
