//
//  TableViewController.swift
//  Cassini
//
//  Created by 虎猫儿 on 15/12/12.
//  Copyright © 2015年 TAC. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let imageURL: String? = tableView.cellForRowAtIndexPath(indexPath)!.detailTextLabel!.text;
        
        self.performSegueWithIdentifier("showImage", sender: NSURL(string: imageURL!))
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let ivc = segue.destinationViewController as? ImageViewController {
            if let imageUrl = sender as? NSURL {
                ivc.imageURL = imageUrl
            }
        }
    }
}
