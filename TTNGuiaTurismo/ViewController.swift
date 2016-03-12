//
//  ViewController.swift
//  TTNGuiaTurismo
//
//  Created by Usuário Convidado on 12/03/16.
//  Copyright © 2016 Thiago Nogueira. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    // mapa
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    // json
    
    var session: NSURLSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // mapa
        
        self.locationManager.requestWhenInUseAuthorization()
        
        // Define minha localizacao e centraliza o mapa nela
        let fiapLocation:CLLocationCoordinate2D  = CLLocationCoordinate2DMake(-23.550303, -46.634184)
        
        self.mapView.region = MKCoordinateRegionMakeWithDistance(fiapLocation, 1200, 1200)
        
        // json
        
        // Cria um configuracao de sessao default!
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        // Cria uma sessao com a configuracao default!
        session = NSURLSession(configuration: sessionConfig)
        
        let url: NSURL = NSURL(string: "http://flameworks.com.br/fiap/pontosTuristicos.txt")!
        let task = self.session!.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            if (error == nil) {
            //				let retStr: String = String(data: data!, encoding: NSUTF8StringEncoding)!
            //				print(retStr)
            if let appName = self.getTopFreeName(data!) {
                dispatch_async(dispatch_get_main_queue(), {
                //self.appTitleLabel.text = appName
                print(appName)
                })
            }
            if let appImageURL = self.getTopFreeImageURL(data!) {
                    self.downloadImage(appImageURL)
            }
        } else {
            print("error")
            }
            })
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }

    func getTopFreeName(data: NSData) -> String? {
        var retStr: String? = nil
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            if let feed = json["feed"] as? [String: AnyObject] {
                if let entry = feed["entry"] as? [String: AnyObject] {
                    if let name = entry["im:name"] as? [String: AnyObject] {
                        if let label = name["label"] as? String {
                            retStr = label
                        }
                    }
                }
            }
        } catch {
            print("Erro no parser JSON")
            return nil
        }
        return retStr
    }
    
    func getTopFreeImageURL(data: NSData) -> String? {
        var retStr: String? = nil
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            if let feed = json["feed"] as? [String: AnyObject] {
                if let entry = feed["entry"] as? [String: AnyObject] {
                    print(entry)
                    if let name = entry["im:image"] as? [AnyObject] {
                        if let label = name[0]["label"] as? String {
                            retStr = label
                        }
                    }
                }
            }
        } catch {
            print("Erro no parser JSON")
            return nil
        }
        
        return retStr
    }
    
    func downloadImage(imgURL: String) {
            let url = NSURL(string: imgURL)!
            let imageSession = NSURLSession.sharedSession()
            let imgTask = imageSession.downloadTaskWithURL(url) { (url, response, error) -> Void in
                if (error == nil) {
                    if let imageData = NSData(contentsOfURL: url!) {
                        dispatch_async(dispatch_get_main_queue(), {
                        //self.appIcoImageView.image = UIImage(data: imageData)
                        print(imageData);
                    })
                }
            } else {
                print("Erro ao baixar imagem")
            }
        }
        imgTask.resume()
    }
}

