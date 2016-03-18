//
//  connectionModel.swift
//  messUp
//
//  Created by Sascha Bencze on 18.03.16.
//  Copyright © 2016 Sascha Bencze. All rights reserved.
//

import Foundation

protocol ConnectionModelProtocal: class {
    func itemsDownloaded(items: NSArray)
}


class ConnectionModel: NSObject,  NSURLConnectionDelegate, NSURLSessionDelegate, NSURLSessionDataDelegate  {

weak var delegate: ConnectionModelProtocal!
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
    self.delegate.itemsDownloaded(items)
    
    
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

}