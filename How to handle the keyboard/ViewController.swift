//
//  ViewController.swift
//  How to handle the keyboard
//
//  Created by Carrington Tafadzwa Manyuchi on 2023/02/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonTapped: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
    }
    
    // MARK: Good Practice to avoid overloading the viewDidLoad with lot of code for readibility
    func configureView() {
        
        self.buttonTapped.layer.cornerRadius = 25
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisplay), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        keyboardHidding()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // MARK: Keyboard will display after the user clicks on the text field and the bottom constraint will be marked from where the height of the keyboard is.
    
    @objc func keyboardWillDisplay(notification: Notification) {
        if let keyboardframe:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardframe.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.bottomConstraint.constant = keyboardHeight - 10
        }
    }
    
    // MARK: Keyboard Remove Method
    func keyboardHidding() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardRemoved))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardRemoved() {
        view.endEditing(true)
    }
    
    // MARK: To restore bottom constraints after the keyboard has been removed
    @objc func keyboardWillHide(notification: Notification) {
        bottomConstraint.constant = 50
    }
    
    

}

