//
//  MEDICALCON.swift
//  iACCESS
//
//  Created by Aakash Panchal on 30/09/24.
//

import UIKit
import SideMenu

class MEDICALCON: UIViewController {
    
    var arrOptionList = [[String:Any]]()


    @IBOutlet weak var collList: UICollectionView!
    @IBOutlet weak var collLetter: UICollectionView!
    @IBOutlet var conCollHeight: NSLayoutConstraint!
    @IBOutlet var conLetterHeight: NSLayoutConstraint!

    @IBOutlet var lblAppname: UILabel!
    
    @IBOutlet var viewUser: UIView!
    @IBOutlet var lblUser: UILabel!
    
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var btnBack: UIButton!

    @IBOutlet var viewSearch: UIView!
    @IBOutlet var txtSearch: UITextField!

    

    
    // MARK:- PRIVATE

    private let mainCatsHandler = MainCategoriesCollectionHandler()
    private let letterHandler = LettersCollectionHandler()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserSettings.shared.arrLetters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        
        
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
        
        // Collection Letter
        
        letterHandler.categories = UserSettings.shared.arrLetters
        self.collLetter.setUp(delegate: letterHandler, dataSource: letterHandler, cellNibWithReuseId: LetterCell.className)
        
        let width1 = ((self.collLetter.frame.size.width ) / 4) - 10
        var count = UserSettings.shared.arrLetters.count/4
        if (UserSettings.shared.arrLetters.count%4) != 0
        {
           count = count + 1
        }
        self.conLetterHeight.constant = (CGFloat(count) * (width1 + 15)) + 15
        self.collLetter.updateConstraintsIfNeeded()
        self.collLetter.layoutIfNeeded()

        
        // Handling actions
        letterHandler.didSelect =  { (indexpath) in
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MEDICALCONDETAIL") as! MEDICALCONDETAIL
            vc.strLetter = UserSettings.shared.arrLetters[indexpath.item]
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
