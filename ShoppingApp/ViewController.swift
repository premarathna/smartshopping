//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Chamali Nirasha on 13/9/19.
//  Copyright © 2019 Chamali Nirasha. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func btnSignIn(_ sender: Any) {
    
    let urlString = "https://reqres.in/api/login"
    
        Alamofire.request(urlString,
                          method: .post,
                          parameters: ["email":"eve.holt@reqres.in","password": "cityslicka"],
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON {
                            response in
                            switch response.result {
                            case .success:
                                print("------------------")
                                print(response)
                                
                                break
                            case .failure(let error):
                                
                                print(error)
                            }
        }
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        
        let urlString = "https://reqres.in/api/register"
        
        Alamofire.request(urlString,
                          method: .post,
                          parameters: ["email":"eve.holt@reqres.in","password": "cityslicka"],
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON {
                            response in
                            switch response.result {
                            case .success:
                                print(response)
                                
                                break
                            case .failure(let error):
                                
                                print(error)
                            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

