//
//  DASHBOARD.swift
//  iACCESS
//
//  Created by Aakash Panchal on 25/09/24.
//

import UIKit
import SideMenu

class DASHBOARD: UIViewController {
    
    var arrOptionList = [[String:Any]]()

    @IBOutlet weak var collList: UICollectionView!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet var conCollHeight: NSLayoutConstraint!
    @IBOutlet var conTblListHeight: NSLayoutConstraint!
    @IBOutlet var lblAppname: UILabel!
    
    @IBOutlet var viewUser: UIView!
    @IBOutlet var lblUser: UILabel!
    
    @IBOutlet var btnMenu: UIButton!


    
    // MARK:- PRIVATE

    private let mainCatsHandler = MainCategoriesCollectionHandler()
    private let mainListsHandler = DashboardListTableHandler()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserSettings.shared.arrCatList = [["name":"Home","image":"home","id":0,"isSelected":"0"],["name":"Work","image":"school","id":1,"isSelected":"0"],["name":"School","image":"backpack","id":2,"isSelected":"0"],["name":"Transit","image":"trasit","id":3,"isSelected":"0"],["name":"Medical","image":"hospital","id":4,"isSelected":"0"],["name":"All","image":"planet" ,"id":5,"isSelected":"0"]]
        
        arrOptionList = [["name":"Accessibility Category","image":"accessibility" ,"id":0],["name":"Medical Conditions","image":"caduceus" ,"id":1],["name":"My Accommodations","image":"accommodation" ,"id":2],["name":"Legal","image":"Law" ,"id":3],["name":"Dictionary ","image":"dictionary" ,"id":4]]
        
        self.ImShSetLayout()

    }
    
    override func ImShSetLayout()
    {
        viewUser.isHidden = true
        
        // collection
        mainCatsHandler.categories = UserSettings.shared.arrCatList
        self.collList.setUp(delegate: mainCatsHandler, dataSource: mainCatsHandler, cellNibWithReuseId: MainCategoriesCell.className)
        
        let width = ((self.collList.frame.width ) / 3) - 10
        self.conCollHeight.constant = (CGFloat((UserSettings.shared.arrCatList.count/3)) * (width + 15)) + 15
        self.collList.updateConstraintsIfNeeded()
        self.collList.layoutIfNeeded()

        
        
        // Handling actions
        mainCatsHandler.didSelect =  { (indexpath) in
            

            for i in 0..<UserSettings.shared.arrCatList.count
            {
                var dict = UserSettings.shared.arrCatList[i]

                if i == indexpath.item
                {
                    dict["isSelected"] = "1"
                }
                else
                {
                    dict["isSelected"] = "0"
                }
                
                UserSettings.shared.arrCatList[i] = dict
            }
            
            self.mainCatsHandler.categories = UserSettings.shared.arrCatList
            self.collList.reloadData()
        }
        
        //Table
        
        mainListsHandler.arrList = arrOptionList
                
                
        self.tblList.setUpTable(delegate: mainListsHandler, dataSource: mainListsHandler, cellNibWithReuseId: TitleCell.className)
        
        mainListsHandler.didSelect =  { (indexpath) in
            
            if indexpath.row == 0 || indexpath.row == 1
            {
                let arr1 = UserSettings.shared.arrCatList.filter { $0["isSelected"] as? String == "1" }
                
                if arr1.count == 0
                {
                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "OOPS", aStrMessage: "Please select any location to proceed", aOKBtnTitle: "Okay") { index, title in
                    }
                }
                else
                {
                    if indexpath.row == 0
                    {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ACCOMMODATION") as! ACCOMMODATION
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else if indexpath.row == 1
                    {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MEDICALCON") as! MEDICALCON
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            else if indexpath.row == 2
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MYACCOMMODATION") as! MYACCOMMODATION
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexpath.row == 3
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LEGAL") as! LEGAL
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexpath.row == 4
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DICTIONARY") as! DICTIONARY
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
        self.conTblListHeight.constant = CGFloat(arrOptionList.count * 70)
        self.tblList.updateConstraintsIfNeeded()
        self.tblList.layoutIfNeeded()

    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

        self.navigationController?.navigationBar.isHidden = true

    }

    
    //Mark: - Button action
    
    @IBAction func btnMenuClick(_ sender: UIButton) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SIDEBAR") as! SIDEBAR
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.menuWidth = (self.view.frame.size.width - 100)
        menu.presentationStyle = .menuSlideIn
        present(menu, animated: true, completion: nil)
        
    }
    

}

extension UICollectionView{

    public func setUp(delegate: UICollectionViewDelegate?, dataSource: UICollectionViewDataSource?, cellNibWithReuseId: String? = nil) {
        if let nibReuseId = cellNibWithReuseId {
            self.register(UINib.init(nibName: nibReuseId, bundle: nil), forCellWithReuseIdentifier: nibReuseId)
        }
        self.delegate = delegate
        self.dataSource = dataSource
    }
}
