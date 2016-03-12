//
//  PontoTuristicoAnnotation.swift
//  TTNGuiaTurismo
//
//  Created by Usuário Convidado on 12/03/16.
//  Copyright © 2016 Thiago Nogueira. All rights reserved.
//

import UIKit
import MapKit

class PontoTuristicoAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: String?

    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, image: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}
