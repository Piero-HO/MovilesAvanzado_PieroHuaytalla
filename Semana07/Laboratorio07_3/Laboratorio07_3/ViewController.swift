//
//  ViewController.swift
//  Laboratorio07_3
//
//  Created by Piero Huaytalla on 14/10/26.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    let culturas: [Cultura] = [
        Cultura(
            nombre: "Caral",
            region: "Lima — valle de Supe",
            descripcion: "Una de las civilizaciones más antiguas de América, destacada por sus centros urbanos y arquitectura monumental.",
            imagen: "caral"),
        Cultura(
            nombre: "Nazca",
            region: "Ica",
            descripcion: "Cultura de la costa sur del Perú, reconocida por sus geoglifos y cerámica policroma.",
            imagen: "nazca"),
        Cultura(
            nombre: "Inca",
            region: "Cusco — expansión por los Andes",
            descripcion: "Civilización que organizó el Tahuantinsuyo, con capital en Cusco y una extensa red de caminos.",
            imagen: "inca")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return culturas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaCultura",for: indexPath)
        let cultura = culturas[indexPath.row]
        celda.textLabel?.text = cultura.nombre
        celda.detailTextLabel?.text = cultura.region
        celda.imageView?.image = UIImage(named: cultura.imagen)
        return celda
    }
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "mostrarDetalle",sender: culturas[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mostrarDetalle",
           let detalle = segue.destination as? DetalleCulturaViewController,
           let cultura = sender as? Cultura {

            detalle.cultura = cultura
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

