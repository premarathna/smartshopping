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
    
    var isSeller: Bool = false
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        
        self.showViewController()
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
                                
//                                self.showViewController()
                                
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
                                break
                            case .failure(let error):
                                
                                print(error) 
                            }
        }
    }
    
    func showViewController() {
        if self.isSeller {
            performSegue(withIdentifier: "sellerSegue", sender: self)
        } else {
            performSegue(withIdentifier: "buyerSegue", sender: self)
        }
    }
    
    @IBAction func btnOption(_ sender: Any) {
        
        let option = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "I'm Seller", style: .default) { (action) in
            self.isSeller = true
        }
        option.addAction(action1)
        let action2 = UIAlertAction(title: "I'm Buyer", style: .default) { (action) in
            self.isSeller = false
        }
        option.addAction(action2)
        present(option, animated: true, completion: nil)
        
    
    
        func viewDidLoad() {
        super.viewDidLoad()
            
        // Do any additional setup after loading the view, typically from a nib.
    }


}
}

