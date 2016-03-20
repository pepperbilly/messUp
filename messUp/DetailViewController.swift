//
//  DetailViewController.swift
//  messUp
//
//  Created by Sascha Bencze on 16.03.16.
//  Copyright © 2016 Sascha Bencze. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController : UIViewController, ConnectionModelProtocal {
    
    func itemsDownloaded(items: NSArray){
        
        dispatch_async(dispatch_get_main_queue()) {
           // self.tableView.reloadData()
        }
    }
    
    var dataPassed:String!
    var dataPassedAddress:String!
    @IBOutlet weak var detailLabelName: UITextField!
    @IBOutlet weak var detailLabelAddress: UILabel!
    
    let connectionModel = ConnectionModel()
    let viewController = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectionModel.delegate = self
        self.detailLabelName.text = String(dataPassed)
        self.detailLabelAddress.text = String(dataPassedAddress)
        print(self.dataPassed)
        print(self.dataPassedAddress)
    }
    
}