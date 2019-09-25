//
//  homeBuy.swift
//  ShoppingApp
//
//  Created by Chamali Nirasha on 14/9/19.
//  Copyright © 2019 Chamali Nirasha. All rights reserved.
//

import UIKit
import CoreData

class homeBuy: UIViewController {
    

    @IBOutlet weak var uiCollection: UICollectionView!
    var itemList: [Items] = []
    var displayItemList: [Items] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.cleanItemsCoreData()
        self.fetchData()
        
        let layout = self.uiCollection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.uiCollection.frame.size.width-20)/2, height: (self.uiCollection.frame.size.height - 30)/3)
    }
    
    func cleanItemsCoreData() {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        request.returnsObjectsAsFaults = false
        
        let results: NSArray = try! context.fetch(request) as NSArray
        
        for item in results {
            context.delete(item as! NSManagedObject)
        }
    }
    
    func fetchData () {
        self.itemList = []
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        request.returnsObjectsAsFaults = false
        
        let items: NSArray = try! context.fetch(request) as NSArray
        if items.count > 0 {
            for item in items {
                let item = item as! Items
                itemList.append(item)
            }
        }
        
        displayItemList = itemList
    }
}

extension homeBuy: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.label1.text = displayItemList[indexPath.item].name
        let itemImage: UIImage = UIImage(data: displayItemList[indexPath.item].image as! Data)!
        cell.image1.image = itemImage
        return cell
        
    }
}

extension homeBuy: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            displayItemList = itemList
        } else {
            displayItemList = itemList.filter {$0.name!.contains(searchText)}
        }
        
        self.uiCollection.reloadData()
    }
}
