//
//  ALLERGIES.swift
//  iACCESS
//
//  Created by Aakash Panchal on 24/10/24.
//

import UIKit

class ALLERGIES: UIViewController {
    
    var arrOptionList = [[String:Any]]()

    @IBOutlet weak var tblList: UITableView!
    @IBOutlet var conTblListHeight: NSLayoutConstraint!
    @IBOutlet var lblAppname: UILabel!
    
    @IBOutlet var viewUser: UIView!
    @IBOutlet var lblUser: UILabel!
    
    @IBOutlet var lblNote: UILabel!
    @IBOutlet var lblDesc: UILabel!

    
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var btnBack: UIButton!
    

    
    // MARK:- PRIVATE

    private let detailListsHandler = AllergyListHandler()


    override func viewDidLoad() {
        super.viewDidLoad()
                    
        arrOptionList = [["name":"Environmental allergies","image":"accessibility" ,"id":0,"description":"Smoke","isSelected":"0"],["name":"Food allergies","image":"vision" ,"id":1,"description":"Eggs","isSelected":"0"],["name":"Medical allergies","image":"vision" ,"id":2,"description":"Insulin","isSelected":"0"]]
        
        self.ImShSetLayout()

    }
    
    override func ImShSetLayout()
    {
        viewUser.isHidden = false

        //Table
        
        detailListsHandler.arrList = arrOptionList
                
                
        self.tblList.setUpTable(delegate: detailListsHandler, dataSource: detailListsHandler, cellNibWithReuseId: AllergyCell.className)
                
        self.tblList.reloadData()
        self.conTblListHeight.constant = CGFloat(self.arrOptionList.count * 80)
        self.tblList.updateConstraintsIfNeeded()
        self.tblList.layoutIfNeeded()

        
        detailListsHandler.didSelect =  { (indexpath) in
            
            var dict = self.arrOptionList[indexpath.row]

            if dict["isSelected"] as? String == "1" {
                dict["isSelected"] = "0"
            }
            else {
                dict["isSelected"] = "1"
            }
            self.arrOptionList[indexpath.row] = dict

            self.detailListsHandler.arrList = self.arrOptionList
            self.tblList.reloadData()
            self.conTblListHeight.constant = self.tblList.contentSize.height
            self.tblList.updateConstraintsIfNeeded()
            self.tblList.layoutIfNeeded()
            self.conTblListHeight.constant = self.tblList.contentSize.height

        }
        
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

        self.navigationController?.navigationBar.isHidden = true

    }

    
    // Mark: - Button action
    
    @IBAction func btnMenuClick(_ sender: UIButton) {
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SIDEBAR") as! SIDEBAR
//        let menu = SideMenuNavigationController(rootViewController: vc)
//        menu.menuWidth = (self.view.frame.size.width - 100)
//        menu.presentationStyle = .menuSlideIn
//        present(menu, animated: true, completion: nil)
        
    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }

    

}
