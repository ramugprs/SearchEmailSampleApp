//
//  UserViewModel.swift
//  SampleApp
//
//  Created by Ramakrishna on 1/31/19.
//  Copyright © 2019 SampleOrg. All rights reserved.
//

import Foundation
import Alamofire

class UserViewModel: NSObject {
    
    func callPostApiFOrUsers(email: String,successResponse: @escaping (_ response: [User]) -> Void, failure: @escaping (_ errorMessage: String) -> Void){
        let urlString = "http://surya-interview.appspot.com/list"
        
        Alamofire.request(urlString, method: .post, parameters: ["emailId": email],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                if let responseObject = response.result.value{
                    let dictResponse = responseObject as! [String:Any]
                    successResponse(self.getResults(dict: dictResponse))
                }
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    func getResults(dict: [String:Any]) ->[User]{
        
        if let tmpArray = UserObjectParser.getParsedUserResponse(response: dict){
            return tmpArray
        }
        return []
    }
}
