//
//  CONFIRMATION.swift
//  iACCESS
//
//  Created by Aakash Panchal on 21/09/24.
//

import UIKit

class CONFIRMATION: UIViewController {
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnChangeEmail: UIButton!
    @IBOutlet var btnResend: UIButton!

    @IBOutlet weak var lblConfirmemail: UILabel!
    @IBOutlet weak var lblAppname: UILabel!
    @IBOutlet weak var lblDesc: UILabel!


    var strEmail : String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
      
        btnContinue.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnChangeEmail.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnResend.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        self.lblConfirmemail.text = "A confirmation email has been sent to " + strEmail

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - button Actions
    
    @IBAction func btnResendClick(_ sender: UIButton) {

    }
   
    @IBAction func btnchangeEmailClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnContinueClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        let otp = self.storyboard?.instantiateViewController(withIdentifier: "LOCATION") as! LOCATION
        self.navigationController?.pushViewController(otp, animated: true)

    }
    
   
    
    // MARK: - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
       
        return true
        
    }

}
