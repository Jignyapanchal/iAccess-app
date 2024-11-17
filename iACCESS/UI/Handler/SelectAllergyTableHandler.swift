//
//  CategoriesWithImageCollectionHandler.swift


import UIKit

// MARK:- UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class SelectAllergyTableHandler : NSObject, UITableViewDelegate, UITableViewDataSource
{
    
//    var categories = [CategoryModel]()
    var strComefrom:String!
    var didSelect: ((IndexPath) -> Void)? = nil
    
    //MARK:- Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionCell.className, for: indexPath) as! SelectionCell
        if strComefrom == "food"
        {
            cell.lblName.text = "Soy"
        } else if strComefrom == "env"
        {
            cell.lblName.text = "Smoke"
        }
        else
        {
            cell.lblName.text = "Iodine"
        }
        
        cell.selectionStyle = .none

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(indexPath)
        
        let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) as! SelectionCell
        cell.imgArw.image = UIImage(systemName: "checkmark.square.fill")
        cell.imgArw.tintColor = UIColor(red: 15/255, green: 192/255, blue: 252/255, alpha: 1)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}



