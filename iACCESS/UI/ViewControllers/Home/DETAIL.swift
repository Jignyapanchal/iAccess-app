//
//  DETAIL.swift
//  iACCESS
//
//  Created by Aakash Panchal on 30/09/24.
//

import UIKit
import SideMenu

    class DETAIL: UIViewController {

        var arrOptionList = [[String:Any]]()

        @IBOutlet weak var collList: UICollectionView!
        @IBOutlet weak var tblList: UITableView!
        @IBOutlet var conCollHeight: NSLayoutConstraint!
        @IBOutlet var conTblListHeight: NSLayoutConstraint!
        @IBOutlet var lblAppname: UILabel!
        
        @IBOutlet var viewUser: UIView!
        @IBOutlet var lblUser: UILabel!
        
        @IBOutlet var btnMenu: UIButton!
        @IBOutlet var btnBack: UIButton!

        @IBOutlet var viewSearch: UIView!
        @IBOutlet var txtSearch: UITextField!

        

        
        // MARK:- PRIVATE

        private let mainCatsHandler = MainCategoriesCollectionHandler()
        private let detailListsHandler = DetailListTableHandler()


        override func viewDidLoad() {
            super.viewDidLoad()
                        
            arrOptionList = [["name":"Lorem Ipsum","image":"accessibility" ,"id":0,"description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.","isSelected":"0"],["name":"Lorem Ipsum","image":"vision" ,"id":1,"description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.","isSelected":"0"],["name":"Lorem Ipsum","image":"vision" ,"id":2,"description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\nExample: Lorem Ipsum is simply dummy text of the printing and typesetting industry. ","isSelected":"0"],["name":"Lorem Ipsum","image":"vision" ,"id":3,"description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.","isSelected":"0"],["name":"Lorem Ipsum","image":"vision" ,"id":4,"description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.","isSelected":"0"]]
            
            self.ImShSetLayout()

        }
        
        override func ImShSetLayout()
        {
            viewUser.isHidden = false
            
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
            
            detailListsHandler.arrList = arrOptionList
                    
                    
            self.tblList.setUpTable(delegate: detailListsHandler, dataSource: detailListsHandler, cellNibWithReuseId: ExpandableCell.className)
            
            self.tblList.estimatedRowHeight = 80
            self.tblList.rowHeight = UITableView.automaticDimension
            
            self.tblList.reloadData()
            self.conTblListHeight.constant = self.tblList.contentSize.height
            self.tblList.updateConstraintsIfNeeded()
            self.tblList.layoutIfNeeded()
            self.conTblListHeight.constant = self.tblList.contentSize.height


            
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
