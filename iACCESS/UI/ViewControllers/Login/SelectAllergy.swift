//
//  SelectAllergy.swift
//  iACCESS
//
//  Created by Aakash Panchal on 21/09/24.
//

import UIKit

class SelectAllergy: UIViewController {
    
    var strcomeFrom:String!
    
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var conTblListHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet var btnback: UIButton!
    @IBOutlet var btnOther: UIButton!
    @IBOutlet var btnIdonothave: UIButton!

    @IBOutlet weak var lblOther: UILabel!
    @IBOutlet weak var lbldesc: UILabel!

    @IBOutlet weak var lblAppname: UILabel!
    @IBOutlet weak var txtOther: UITextField!


    
    private let allergylisthandler = SelectAllergyTableHandler()



    override func viewDidLoad() {
        super.viewDidLoad()
        self.ImShSetLayout()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

        btnNext.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnback.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
    }
    
    override func ImShSetLayout()
    {
        if strcomeFrom == "food" {
            
            lbldesc.text = "Any food allergies?"

        } else if strcomeFrom == "env"{
            
            lbldesc.text = "Any environmental allergies?"

        }
        else {
            
            lbldesc.text = "Any medical allergies?"

        }
                
        
        allergylisthandler.strComefrom = strcomeFrom
//        self.tblList.estimatedRowHeight = 60
//        self.tblList.rowHeight = UITableView.automaticDimension
        
        
        self.tblList.setUpTable(delegate: allergylisthandler, dataSource: allergylisthandler, cellNibWithReuseId: SelectionCell.className)
        
        self.conTblListHeight.constant = 50*10
        self.tblList.updateConstraintsIfNeeded()
        self.tblList.layoutIfNeeded()
//        self.conTblListHeight.constant = self.tblList.contentSize.height
    }

    

    // MARK: - button Actions
    
    @IBAction func btnOtherClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnIdonotHaveClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        if txtOther.text?.count == 0
        {
          
        }
        
        if strcomeFrom == "food" {
            let select = self.storyboard?.instantiateViewController(withIdentifier: "SelectAllergy") as! SelectAllergy
            select.strcomeFrom = "env"
            self.navigationController?.pushViewController(select, animated: true)

        } else if strcomeFrom == "env"{
            
            let select = self.storyboard?.instantiateViewController(withIdentifier: "SelectAllergy") as! SelectAllergy
            select.strcomeFrom = "medical"
            self.navigationController?.pushViewController(select, animated: true)
        }
        else
        {

            UserSettings.shared.setLoggedIn()
            self.view.endEditing(true)
            let storyboard = UIStoryboard.init(name: "Dashboard", bundle: nil)
            let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
            AppDelegate.shared.window?.rootViewController = navigationController
            AppDelegate.shared.window?.makeKeyAndVisible()
            
        }
        


    }
    
   
    
    // MARK: - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
       
        return true
        
    }

}

extension UITableView {
    
    public func setUpTable(delegate: UITableViewDelegate?, dataSource: UITableViewDataSource?, cellNibWithReuseId: String? = nil) {
        if let nibReuseId = cellNibWithReuseId {
            
            self.register(UINib.init(nibName: nibReuseId, bundle: nil), forCellReuseIdentifier: nibReuseId)
        }
        self.delegate = delegate
        self.dataSource = dataSource
    }
}
