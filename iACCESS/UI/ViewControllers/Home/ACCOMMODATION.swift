//
//  ACCOMMODATION.swift
//  iACCESS
//
//  Created by Aakash Panchal on 29/09/24.
//

import UIKit
import SideMenu


class ACCOMMODATION: UIViewController {
    
        var arrOptionList = [[String:Any]]()

        @IBOutlet weak var collList: UICollectionView!
        @IBOutlet weak var collOptions: UICollectionView!
        @IBOutlet var conCollHeight: NSLayoutConstraint!
        @IBOutlet var conCollOptionHeight: NSLayoutConstraint!
        @IBOutlet var lblAppname: UILabel!
        
        @IBOutlet var viewUser: UIView!
        @IBOutlet var lblUser: UILabel!
        
        @IBOutlet var btnMenu: UIButton!
        @IBOutlet var btnBack: UIButton!


        
        // MARK:- PRIVATE

        private let mainCatsHandler = MainCategoriesCollectionHandler()
        private let optionHandler = OptionCollectionHandler()


        override func viewDidLoad() {
            super.viewDidLoad()
                        
            arrOptionList = [["name":"Vision","image":"vision" ,"id":0,"isSelected":"0"],["name":"Hearing","image":"hearing" ,"id":1,"isSelected":"0"],["name":"Mobility","image":"mobility" ,"id":2],["name":"Cognitive","image":"Law" ,"id":3,"isSelected":"0"],["name":"Sensory ","image":"dictionary" ,"id":4,"isSelected":"0"],["name":"Allergy ","image":"dictionary" ,"id":5,"isSelected":"0"],["name":"Safety ","image":"dictionary" ,"id":6,"isSelected":"0"]]
            
            self.ImShSetLayout()

        }
        
        override func ImShSetLayout()
        {
            viewUser.isHidden = false
            
            // collection Category
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
            
            //Collection Options
            
            optionHandler.categories = self.arrOptionList
            
            self.collOptions.setUp(delegate: optionHandler, dataSource: optionHandler, cellNibWithReuseId: MainCategoriesCell.className)
            
            
            
            let width1 = ((self.collOptions.frame.width ) / 3) - 10
            var count = self.arrOptionList.count/3
            if (self.arrOptionList.count%3) != 0
            {
               count = count + 1
            }
            self.conCollOptionHeight.constant = (CGFloat(count) * (width1 + 15)) + 15
            self.collOptions.updateConstraintsIfNeeded()
            self.collOptions.layoutIfNeeded()

            
            
            // Handling actions
            optionHandler.didSelect =  { (indexpath) in
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DETAIL") as! DETAIL
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
