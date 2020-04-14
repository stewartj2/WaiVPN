//
//  ServerControllerTableViewController.swift
//  WaiVPN
//
//  Created by Jaden Stewart on 22/12/19.
//  Copyright © 2019 Jaden Stewart. All rights reserved.
//

import UIKit

class ServerTableViewController: UITableViewController {


    // MARK: - Table view data source
    
    // Will only display 2 sections (it shows 2 New Zealand sections just as placeholders)
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 2
    }
    
    // There is a title above the section and it will display New Zealand on both sections
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "New Zealand"
        
    }
    
    // In each section it will display 3 rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    // This is a very over complicated algorithm that will make it show a checkmark in each table view row. (If a user clicks on a row then the checkmark will move to that row and delete the checkmark on the old row, this is to show what server the user is using)
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let numberOfRows = tableView.numberOfRows(inSection: section)
        
        for row in 0..<numberOfRows {
            
            if let cell = tableView.cellForRow(at: NSIndexPath(row: row, section: section) as IndexPath) {
                
                cell.accessoryType = row == indexPath.row ? .checkmark : .none
            }
        }
        
    }
    
    // The cases here will display each row in the section (1, Masterton)
    //                                                     (2, Christchurch)
    //                                                     (3, Auckland)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        
        // this constant below makes a cell (row) with the indentifier "masterton". I can then use the identifier to make changes to that specific cell in future
        case 0:
            let masterton = tableView.dequeueReusableCell(withIdentifier: "masterton", for: indexPath)

                return masterton
            
        // this constant below makes a cell (row) with the indentifier "christchurch". I can then use the identifier to make changes to that specific cell in future
        case 1:
            let christchurch = tableView.dequeueReusableCell(withIdentifier: "christchurch", for: indexPath)
            
            return christchurch
            
        // this constant below makes a cell (row) with the indentifier "auckland". I can then use the identifier to make changes to that specific cell in future
        case 2:
            let auckland = tableView.dequeueReusableCell(withIdentifier: "auckland", for: indexPath)
            
            return auckland
            
        // If none of those cases can be displayed for an unknown reason/error than just return a blank table view cell
        default:
            return UITableViewCell()
            
        }
        
    }
    
    // When this view controller gets loaded into memory for the first time it will run these lines of code
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This class will act as the tableViews data source
        self.tableView.dataSource = self
        
        //This class will act as the tableViews delegate to send messages to other objects
        self.tableView.delegate = self
        view = tableView
    }
    
    /*
     
     Below code is generated by Xcode, I keep it there if I need to use the functions in thr future
     
     */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}