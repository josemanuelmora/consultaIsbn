//
//  ViewController.swift
//  ConsultaISBN
//
//  Created by José Manuel Mora on 14/03/16.
//  Copyright © 2016 José Manuel Mora. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.txtIsbn.delegate = self
        
    }
    
    @IBOutlet weak var txtResult: UITextView!
    @IBOutlet weak var txtIsbn: UITextField!
    
    @IBAction func btnClear(sender: AnyObject) {
        txtIsbn.text=""
        txtResult.text=""
    }


    @IBAction func IsbnSearch(sender: UITextField) {
        txtIsbn.resignFirstResponder()  //if desired
        performAction()
        
    }
    
    func performAction() {
        revisar()
        //action events
    }
    
    @IBAction func btnSearch(sender: AnyObject) {
        
        revisar()
        
    }
    
    func revisar()
    {
        let dirIni = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let dir = dirIni + txtIsbn.text!
        let url = NSURL(string: dir)
        let datos:NSData? = NSData(contentsOfURL: url!)
        
        var error = ""
        
        if (datos != nil){
            let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
            txtResult.text = String(texto)

        }
        else
        {
            error = "No hay conexión a Internet"
            txtResult.text = error

        }
        
        //print(texto)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

