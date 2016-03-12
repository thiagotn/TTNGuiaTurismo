//
//  DetalheController.swift
//  TTNGuiaTurismo
//
//  Created by Usuário Convidado on 12/03/16.
//  Copyright © 2016 Thiago Nogueira. All rights reserved.
//

import UIKit

class DetalheController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var labelSubtitulo: UILabel!
    
    var titulo: String = ""
    var imagem: String = ""
    var subtitulo: String = ""
    var data: NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelName.text = titulo
        labelSubtitulo.text = subtitulo
        
        let url = NSURL(string:imagem)
        data = NSData(contentsOfURL:url!)
        if data != nil {
            img?.image = UIImage(data:data!)
        }                
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
