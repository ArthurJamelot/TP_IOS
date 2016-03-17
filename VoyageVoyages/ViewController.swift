//
//  ViewController.swift
//  VoyageVoyages
//
//  Created by arthur jamelot on 05/02/2016.
//  Copyright © 2016 arthur jamelot et charles bordier. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var myData = Voyages()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.myTableView.delegate=self
        self.myTableView.dataSource=self
        self.myTextField.delegate=self
        let voy1: Voyage = Voyage(nom: "Paris")
        let voy2: Voyage = Voyage(nom: "Montpellier")
        let voy3: Voyage = Voyage(nom: "Londres")
        let voys: Voyages = Voyages()
        var voyage: Voyage
        try! voys.ajouter(voy1)
        try! voys.ajouter(voy2)
        try! voys.ajouter(voy3)
        for var compteur = 0; compteur<voys.tableau.count; ++compteur {
            do {
                try voyage = voys.position(compteur)
                try self.myData.ajouter(voyage)
                self.myTableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Fade)
                self.myTableView.reloadData()
            } catch {}
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myTextField: UITextField!

    @IBAction func buttonClicked(sender: AnyObject) {
        //Récuperer texte du textfield
        //ajouter le texte comme nouvelle donnée de ma classe Modèle (ma classe métier)
        insertIntoTable()
    }
    
    private func insertIntoTable() {
        if let stext = self.myTextField.text where !self.myTextField.text!.isEmpty {
            do {
                self.myTextField.text = ""
                try self.myData.ajouter((Voyage(nom: stext)))
                //pour contrôle, change le texte du label
                self.myLabel.text = stext
                self.myTableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Fade)
                self.myTableView.reloadData()
            } catch {
                return
            }
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.myData.tableau.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("myCellId", forIndexPath: indexPath) as! MyTableViewCell
    
    // Configure the cell...
    try! cell.myCellLabel.text = self.myData.position(indexPath.row).nom!
        
    return cell
   
    }
    
    // MARK: - Textfield delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        insertIntoTable()
        self.myTextField.resignFirstResponder()
        return true
    }
    
}

