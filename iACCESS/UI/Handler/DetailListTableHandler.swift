//
//  DashboardListTableHandler.swift


import UIKit

// MARK:- UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class DetailListTableHandler : NSObject, UITableViewDelegate, UITableViewDataSource
{
    
    var arrList = [[String:Any]]()
    var strComefrom:String!
    var didSelect: ((IndexPath) -> Void)? = nil
    
    //MARK:- Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCell.className, for: indexPath) as! ExpandableCell
        
        let dict = arrList[indexPath.row]
        
        
        if strComefrom == "medical" {
            
            cell.lblTitle.text = dict["name"] as? String
            cell.viewimg.isHidden = true
            cell.viewDesc.isHidden = true

        }
        else if strComefrom == "dictionary" {
            
            cell.lblTitle.text = dict["name"] as? String
            cell.lblDesc.text = dict["description"] as? String
            cell.viewimg.isHidden = true
            cell.btnBookmark.isHidden = true
            
            if dict["isSelected"] as? String  == "1"
            {
                cell.stackData.backgroundColor = UIColor(named: "themeblue")
                cell.viewDesc.isHidden = false
            }
            else
            {
                cell.stackData.backgroundColor = UIColor(named: "themelightgray")
                cell.viewDesc.isHidden = true
            }

        }
        else
        {
            cell.lblTitle.text = dict["name"] as? String
            cell.img.image = UIImage(named: dict["image"] as? String ?? "")
            cell.lblDesc.text = dict["description"] as? String
            
            if dict["isSelected"] as? String  == "1"
            {
                cell.stackData.backgroundColor = UIColor(named: "themeblue")
                cell.viewimg.isHidden = false
                cell.viewDesc.isHidden = false
            }
            else
            {
                cell.stackData.backgroundColor = UIColor(named: "themelightgray")
                cell.viewimg.isHidden = true
                cell.viewDesc.isHidden = true
            }
        }
        
        cell.btnBookmark.tag = indexPath.row
        cell.btnBookmark.addTarget(self, action: #selector(btnBookmarkClick(_ :)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(indexPath)
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if strComefrom == "medical" {
            return 80
        }
        return UITableView.automaticDimension
    }
    
    @objc func btnBookmarkClick(_ sender: Any) {
        
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
        
    }
    
}



