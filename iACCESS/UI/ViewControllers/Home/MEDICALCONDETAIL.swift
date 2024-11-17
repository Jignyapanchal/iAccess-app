//
//  MEDICALCONDETAIL.swift
//  iACCESS
//
//  Created by Aakash Panchal on 30/09/24.
//

import UIKit
import SideMenu

class MEDICALCONDETAIL: UIViewController {
    
    var arrOptionList = [[String:Any]]()
    var strLetter : String = ""

    @IBOutlet weak var tblList: UITableView!
    @IBOutlet var conTblListHeight: NSLayoutConstraint!
    @IBOutlet var lblAppname: UILabel!
    
    @IBOutlet var viewUser: UIView!
    @IBOutlet var lblUser: UILabel!
    
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var btnBack: UIButton!

    @IBOutlet var viewSearch: UIView!
    @IBOutlet var txtSearch: UITextField!

    

    
    // MARK:- PRIVATE

    private let detailListsHandler = DetailListTableHandler()


    override func viewDidLoad() {
        super.viewDidLoad()
                    
        arrOptionList = [["name":"Lorem Ipsum","image":"accessibility" ,"id":0,"isSelected":"0"],["name":"Lorem Ipsum","image":"vision" ,"id":1,"isSelected":"0"],["name":"Lorem Ipsum","image":"vision" ,"id":2,"isSelected":"0"],["name":"Lorem Ipsum","image":"vision" ,"id":3,"isSelected":"0"],["name":"Lorem Ipsum","image":"vision" ,"id":4,"isSelected":"0"]]
        
        self.ImShSetLayout()

    }
    
    override func ImShSetLayout()
    {
        viewUser.isHidden = false
        
        lblUser.text = strLetter
        

        //Table
        
        detailListsHandler.strComefrom = "medical"
        detailListsHandler.arrList = arrOptionList
                
                
        self.tblList.setUpTable(delegate: detailListsHandler, dataSource: detailListsHandler, cellNibWithReuseId: ExpandableCell.className)
                
        self.tblList.reloadData()
        self.conTblListHeight.constant = CGFloat(self.arrOptionList.count * 80)
        self.tblList.updateConstraintsIfNeeded()
        self.tblList.layoutIfNeeded()

        
        detailListsHandler.didSelect =  { (indexpath) in
                        
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ACCOMMODATION") as! ACCOMMODATION
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

        self.navigationController?.navigationBar.isHidden = true

    }

    
    // Mark: - Button action
    
    @IBAction func btnMenuClick(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SIDEBAR") as! SIDEBAR
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.menuWidth = (self.view.frame.size.width - 100)
        menu.presentationStyle = .menuSlideIn
        present(menu, animated: true, completion: nil)
        
    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }

    

}
