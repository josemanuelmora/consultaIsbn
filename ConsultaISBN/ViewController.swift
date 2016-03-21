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
    
    @IBOutlet weak var txtIsbn: UITextField!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblAutores: UILabel!
    @IBOutlet weak var imgPortada: UIImageView!
    
    @IBAction func btnClear(sender: AnyObject) {
        txtIsbn.text=""
        lblAutores.text=""
        lblTitulo.text=""
        imgPortada.image = nil;
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
            /*
            let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
            txtResult.text = String(texto)
            */
            
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                let dicJson = json as! NSDictionary
                
                if let dicISBN = dicJson["ISBN:\(txtIsbn.text!)"] as! NSDictionary! {
                    
                    lblTitulo.text = dicISBN["title"] as! NSString as String
                    
                    let dicAutores = dicISBN["authors"] as! NSArray
                    var autores = ""
                    
                    for autor in dicAutores {
                        autores += "- \(autor["name"]!!)\n"
                    }
                    lblAutores.text = autores
                    
                    
                    
                    imgPortada.image = nil
                    
                    if let dicCover = dicISBN["cover"] as! NSDictionary! {
                        if let url  = NSURL(string: dicCover["medium"] as! NSString as String), data = NSData(contentsOfURL: url) {
                            imgPortada.image = UIImage(data: data)
                        }
                    }
                    
                    
                }
            } catch _
            {
                print("Ocurrió un error al obtener la información")
            }

        }
        else
        {
            error = "No hay conexión a Internet"
            lblTitulo.text = error

        }
        
        txtIsbn.resignFirstResponder()
        //print(texto)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

