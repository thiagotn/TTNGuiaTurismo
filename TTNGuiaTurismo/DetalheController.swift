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
        
        let actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
            actInd.center = self.view.center
            actInd.hidesWhenStopped = true
            actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(actInd)
            actInd.startAnimating()
        
        dispatch_async(dispatch_get_main_queue(), {
            //self.carregaPontosTuristicosNoMapa(data!)
            self.carregaImagem(self.imagem)
            actInd.stopAnimating()
        })
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func carregaImagem(imagem: String) {
        let url = NSURL(string:imagem)
        data = NSData(contentsOfURL:url!)
        if data != nil {
            img?.image = UIImage(data:data!)
        }
    }
}
