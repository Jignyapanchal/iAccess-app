//
//  MainCategoriesCollectionHandler.swift
//

import UIKit

class OptionCollectionHandler: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var categories = [[String:Any]]()
    var didSelect: ((IndexPath) -> Void)? = nil


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoriesCell.className, for: indexPath) as! MainCategoriesCell
        
        let dict = categories[indexPath.item]
        
        cell.conImgHeight.constant = 55
        cell.thumb.image = UIImage(named: dict["image"] as? String ?? "")
        cell.titleLbl.text = dict["name"] as? String ?? ""
        cell.viewBg.backgroundColor = UIColor(named: "themeblue")


        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.didSelect?(indexPath)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width ) / 3) - 10
        return CGSize.init(width: width, height: width)
    }
    
}
