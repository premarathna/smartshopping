//
//  homeBuy.swift
//  ShoppingApp
//
//  Created by Chamali Nirasha on 14/9/19.
//  Copyright © 2019 Chamali Nirasha. All rights reserved.
//

import UIKit

class homeBuy: UIViewController {
    

    @IBOutlet weak var uiCollection: UICollectionView!
    
    let items = ["Car","House","Laptop","Phone","dog","Cupboard"]
    var displayItems = ["Car","House","Laptop","Phone","dog","Cupboard"]
    
    let itemImages: [UIImage] = [
        UIImage(named: "car")!,
        UIImage(named: "house")!,
        UIImage(named: "lap")!,
        UIImage(named: "phone")!,
        UIImage(named: "dog")!,
        UIImage(named: "cupboard")!
        
    ]
    
    var displayItemImages: [UIImage] = [
        UIImage(named: "car")!,
        UIImage(named: "house")!,
        UIImage(named: "lap")!,
        UIImage(named: "phone")!,
        UIImage(named: "dog")!,
        UIImage(named: "cupboard")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension homeBuy: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.label1.text = displayItems[indexPath.item]
        cell.image1.image = displayItemImages[indexPath.item]
        return cell
        
    }
}

extension homeBuy: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            displayItems = items
            displayItemImages = itemImages
            self.uiCollection.reloadData()
        } else {
            displayItems = items.filter {$0.contains(searchText)}
            setImagesForItems()
        }
    }
    
    func setImagesForItems() {
        for item in displayItems {
            let index = items.index(of: item)
            displayItemImages[displayItems.index(of: item)!] = itemImages[index!]
        }
        self.uiCollection.reloadData()
    }
}
