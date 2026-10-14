//
//  DetalleCulturaViewController.swift
//  Laboratorio07_3
//
//  Created by Piero Huaytalla on 14/10/26.
//

import UIKit

class DetalleCulturaViewController: UIViewController {
    
    @IBOutlet weak var imgCultura: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblRegion: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    
    var cultura: Cultura?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let cultura = cultura else { return }

        title = cultura.nombre
        lblNombre.text = cultura.nombre
        lblRegion.text = cultura.region
        lblDescripcion.text = cultura.descripcion
        imgCultura.image = UIImage(named: cultura.imagen)

    }
    

}
