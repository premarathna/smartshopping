//
//  buyerView.swift
//  ShoppingApp
//
//  Created by Chamali Nirasha on 25/9/19.
//  Copyright © 2019 Chamali Nirasha. All rights reserved.
//

import UIKit

class buyerView: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var priceTxt: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var details: UILabel!
    
    @IBAction func buyBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "Success!", message: "Your purchase proceed successflly!!!!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    var item: Items?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = self.item {
            
            nameTxt.text = item.name
            priceTxt.text = String(item.price)
            location.text = item.location
            details.text = item.details
            let itemImage: UIImage = UIImage(data: item.image as! Data)!
            imageView.image = itemImage
            
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
