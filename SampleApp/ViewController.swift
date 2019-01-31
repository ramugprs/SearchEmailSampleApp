//
//  ViewController.swift
//  SampleApp
//
//  Created by Ramakrishna on 1/31/19.
//  Copyright © 2019 SampleOrg. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func validateEmailWithString(checkString:String) -> Bool {
        
        let laxString = ".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*"
        let EmailTest = NSPredicate(format: "SELF MATCHES %@",laxString)
        let isValid = EmailTest.evaluate(with: checkString)
        return isValid;
    }
    
    @IBAction func submitButtonAction(sender: UIButton){
        if validateEmailWithString(checkString: emailTF.text!){
            errorLabel.isHidden = true
            emailTF.resignFirstResponder()
            self.performSegue(withIdentifier: "EmailSegueID", sender: nil)
        }
        else{
            errorLabel.isHidden = false
        }
    }
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        if segue.destination is EmailListViewController{
            let emailVC = segue.destination as? EmailListViewController
            emailVC?.emailStr = emailTF.text!
        }
     }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

