//
//  ViewController.swift
//  Meme 1.0
//
//  Created by fabriceberetta on 1/4/17.
//  Copyright © 2017 fabriceberetta. All rights reserved.
//

import UIKit
import NotificationCenter

class MemeEditViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {

    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var bottomNavBar: UIToolbar!
    @IBOutlet weak var topNavBar: UINavigationBar!

    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack",size:40)!,
        NSStrokeWidthAttributeName: -3.0
    ]
    
      // functions to create the Meme and store in the shared model in app delegate
    
    
    
    func createMeme() {
        //create the meme
        let meme = memeObject(topText: topTextField.text!, bottomText: bottomTextField.text!, selectedImage: imagePickerView.image!, memedImage: generateMemedImage())
        
        //saves the data in shared model on AppDelegate
        let object=UIApplication.shared.delegate
        let appDelegate=object as! AppDelegate
        appDelegate.memes.append(meme)
      
        
    }
    
    func generateMemedImage()->UIImage{
        
        topNavBar.isHidden = true
        bottomNavBar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        bottomNavBar.isHidden = false
        topNavBar.isHidden=false
        
        return memedImage
        
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // assigns ViewController as delegate for both text fields
        
        topTextField.delegate=self
        bottomTextField.delegate=self
        
        
        setTextFields()
        
        //Disable the share button in absence of picked image
        shareButton.isEnabled=false
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled=UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        self.tabBarController!.tabBar.isHidden=true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeToKeyboardNotifications()
    }
    
    
    // Image picking functions
    
    
    func pickImage(_ pickerController:UIImagePickerController,sourceType: UIImagePickerControllerSourceType) {
        pickerController.delegate=self
        pickerController.sourceType = sourceType
        self.present(pickerController, animated: true, completion: nil)
    }

    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
       pickImage(UIImagePickerController(), sourceType: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickImage(UIImagePickerController(), sourceType: .camera)
    }
    
    // function to enables Share Button if an image is picked
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image=image
            shareButton.isEnabled=true
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
  
    //Text editing functions
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text=""
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
        //Initializes Text Fields
    
   
    
    func formatTextField(_ textField: UITextField, string:String) {
        textField.text=string.uppercased()
        textField.defaultTextAttributes=memeTextAttributes
        textField.textAlignment = .center
        bottomTextField.autocapitalizationType = .allCharacters
    }
    
    func setTextFields() {
        formatTextField(topTextField, string: "top")
        formatTextField(bottomTextField, string: "bottom")
    }
    
        // Uppercase characters in text fields - programmatic way
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string.uppercased()) as NSString
        return true
        
    }
    
    //Notification functions
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillshow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillhide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // Functions to remove the keyboard out of the way for bottom text field
    func keyboardwillshow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardwillhide(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
        view.frame.origin.y += getKeyboardHeight(notification)
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo=notification.userInfo
        let keyboardSize=userInfo![UIKeyboardFrameEndUserInfoKey] as!NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // Top Nav Bar functions: Share and Cancel
    
    @IBAction func cancelMeme(_ sender: Any) {
        setTextFields()
        shareButton.isEnabled=false
        imagePickerView.image=nil
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let memedImage=generateMemedImage()
        let activityViewController=UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
        activityViewController.completionWithItemsHandler = {
            (activity, completed, items, error) in
            if completed {
                self.createMeme()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    
}

