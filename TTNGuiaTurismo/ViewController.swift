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
                let retStr: String = String(data: data!, encoding: NSUTF8StringEncoding)!
                print(retStr)
                dispatch_async(dispatch_get_main_queue(), {
                    self.carregaPontosTuristicosNoMapa(data!)
                })

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
    
    func carregaPontosTuristicosNoMapa(data: NSData) {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            if let places = json["locais"] as? [[String: AnyObject]] {

            for place in places {
                print(place["nome"]!)
                
                let nome: String? = place["nome"] as? String
                let endereco: String? = place["endereco"] as? String
                let imagem: String? = place["imagem"] as? String
                
                var coordenada = place["coordenadas"] as? [String: AnyObject]
                let lat: Double! = coordenada!["lat"] as? Double
                let long: Double! = coordenada!["lon"] as? Double
                print("Lat \(lat) - Long \(long)")

                let pontoTuristicoAnnotation: PontoTuristicoAnnotation = PontoTuristicoAnnotation(coordinate: CLLocationCoordinate2DMake(lat, long), title: nome!, subtitle: endereco!, image: imagem!)
                
                self.mapView.addAnnotation(pontoTuristicoAnnotation)
                
            }
            }
        } catch {
            print("Erro no parser JSON")
        }
    }
}

