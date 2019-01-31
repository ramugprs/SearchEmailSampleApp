//
//  UserObjectParser.swift
//  SampleApp
//
//  Created by Ramakrishna on 1/31/19.
//  Copyright © 2019 SampleOrg. All rights reserved.
//

import UIKit

class UserObjectParser: NSObject {
    
    static func getParsedUserResponse(response: [String: Any]) -> [User]? {
        
        guard let items = response["items"] as? [[String: Any]] else {
            return nil
        }
        var array = [User]()
        if items.count > 0{
            for dict in items{
                let fName = dict["firstName"] as? String ?? ""
                let lName = dict["lastName"] as? String ?? ""
                let emailId = dict["emailId"] as? String ?? ""
                let imageUrlStr = dict["imageUrl"] as? String ?? ""
                let userDetails = User(firstName: fName, lastName: lName, email: emailId, imageUrl: imageUrlStr)
                array.append(userDetails)
            }
        }
        return array
    }

}
