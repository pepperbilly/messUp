//
//  ViewController.swift
//  messUp
//
//  Created by Sascha Bencze on 15.03.16.
//  Copyright © 2016 Sascha Bencze. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ConnectionModelProtocal {
    
    func itemsDownloaded(items: NSArray){
        
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var meinEingabeFeld: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let connectionModel = ConnectionModel()
    var detailName:String!
    var detailAddress:String!
    
    
    func schwips(schnaps: String)  {
       print(schnaps)
    }
        override func viewDidLoad() {
        
        self.schwips("vodka")
        //connectionModel.downloadItems()
        
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //abstände Links Raus
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.preservesSuperviewLayoutMargins = false
        self.tableView.layoutMargins = UIEdgeInsetsZero
            
            connectionModel.delegate = self
            connectionModel.downloadItems()
            
        

       
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    

    
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connectionModel.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = connectionModel.items[indexPath.row]
        
        //abstände Links Raus
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.detailName = String(connectionModel.items[indexPath.row])
        self.detailAddress = String(connectionModel.itemsAddress[indexPath.row])
       // print(detailName)
        self.performSegueWithIdentifier("detailSegue", sender: self)
    }
    
      override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "detailSegue") {
            var svc = segue.destinationViewController as! DetailViewController;
            svc.dataPassed = self.detailName
            svc.dataPassedAddress = self.detailAddress
            //svc.secondDataPassed = fieldB.text
        }
    }
    
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    

    
    
    @IBAction func meineResetAction(sender: AnyObject) {
        connectionModel.items = []
        self.tableView.reloadData()
    
    }

    @IBAction func meineEingabeAction(sender: AnyObject) {
        connectionModel.downloadItems()
        meinEingabeFeld.resignFirstResponder()
        
        if(meinEingabeFeld.text! == "")
        {
            print("leeer")
        }else{
        
            connectionModel.items += [meinEingabeFeld.text!]
            self.tableView.reloadData()
            meinEingabeFeld.text = String("")
           
        }
    }
    

}

