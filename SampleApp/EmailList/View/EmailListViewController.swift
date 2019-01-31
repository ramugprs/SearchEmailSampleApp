//
//  EmailListViewController.swift
//  SampleApp
//
//  Created by Ramakrishna on 1/31/19.
//  Copyright © 2019 SampleOrg. All rights reserved.
//

import UIKit
import SDWebImage

class EmailListViewController: UIViewController {

    @IBOutlet weak var userTableViewList: UITableView!
    var usersListArray = [User]()
    var emailStr: String = ""
    var userModel: UserViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    fileprivate func setUI() {
        userModel = UserViewModel()
        userTableViewList.tableFooterView = UIView(frame: CGRect.zero)
        userTableViewList.estimatedRowHeight = 45
        
        if let tmpDict = UserDefaults.standard.value(forKey: "UsersResponseList") as? [String: Any], tmpDict.keys.count > 0{
            self.updateResultsWithUI(users: userModel!.getResults(dict: tmpDict))
        }
        callPostApi()
    }
    fileprivate func callPostApi() {
        
        userModel?.callPostApiFOrUsers(email: emailStr,successResponse: { (results) in
            self.updateResultsWithUI(users: results)
        }) { (errorMessage) in
            
        }
    }
    func updateResultsWithUI(users: [User]){
        usersListArray.removeAll()
        usersListArray = users
        userTableViewList.reloadData()
    }
}
extension EmailListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! UserTableViewCell
        let user = usersListArray[indexPath.row]
        cell.fullNameLabel.text = user.firstName + " " + user.lastName
        cell.emailLabel.text = user.email
        cell.tumbnailImage.sd_setImage(with: URL(string: user.imageUrl), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersListArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
