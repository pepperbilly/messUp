//
//  ViewController.swift
//  messUp
//
//  Created by Sascha Bencze on 15.03.16.
//  Copyright © 2016 Sascha Bencze. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate, NSURLSessionDelegate, NSURLSessionDataDelegate  {
    
    
    @IBOutlet weak var meinEingabeFeld: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var items = [String]()
    let urlPath: String = "http://localhost:8888/appTest/"
    var data : NSMutableData = NSMutableData()
    
    func parseJSON() {
        
        var jsonResult: NSMutableArray = NSMutableArray()
        do{
            jsonResult = try NSJSONSerialization.JSONObjectWithData(self.data, options:NSJSONReadingOptions.AllowFragments) as! NSMutableArray
            
        } catch let error as NSError {
            print(error)
            
        }
        //////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////
        var jsonElement: NSDictionary = NSDictionary()
        for(var i = 0; i < jsonResult.count; i++)
        {
            jsonElement = jsonResult[i] as! NSDictionary
            if let name = jsonElement["Name"] as? String{ self.items.append(name) }
            
        }
        //////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////
      self.tableView.reloadData()
    }

    
   
    func downloadItems() {
        let url: NSURL = NSURL(string: urlPath)!
        var session: NSURLSession!
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTaskWithURL(url)
        task.resume()
        
        
    }
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        self.data.appendData(data);
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            print("Failed to download data")
        }else {
            print("Data downloaded")
              self.parseJSON()
            
        }
        
    }

    
    func schwips(schnaps: String)  {
       print(schnaps)
    }
        override func viewDidLoad() {
        
        self.schwips("vodka")
        self.downloadItems()
        
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //abstände Links Raus
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.preservesSuperviewLayoutMargins = false
        self.tableView.layoutMargins = UIEdgeInsetsZero
            
        

       
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        //abstände Links Raus
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
                self.performSegueWithIdentifier("detailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
       
    }
    
    
    
    
    @IBAction func meineResetAction(sender: AnyObject) {
        items = []
        self.tableView.reloadData()
    
    }

    @IBAction func meineEingabeAction(sender: AnyObject) {
        self.downloadItems()
        meinEingabeFeld.resignFirstResponder()
        
        if(meinEingabeFeld.text! == "")
        {
            print("leeer")
        }else{
        
            items += [meinEingabeFeld.text!]
            self.tableView.reloadData()
            meinEingabeFeld.text = String("")
           
        }
    }
    

}

