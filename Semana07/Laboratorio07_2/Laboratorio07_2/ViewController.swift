//
//  ViewController.swift
//  Laboratorio07_2
//
//  Created by Piero Huaytalla on 14/10/26.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var personasArreglo = ["Jaime Gomez", "Juan León", "Silvia Montoya","Theo Diaz", "Elliot Garamendi"]
    var personasImagenarreglo = ["avatar3", "avatar2", "avatar1", "avatar4", "avatar5"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personasArreglo.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda",for: indexPath) as! PersonasTableViewCell
        cell.lblNombre.text = personasArreglo[indexPath.row]
        cell.imgFoto.image = UIImage(named: personasImagenarreglo[indexPath.row])
        return cell }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {return 80}
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        let nombre = personasArreglo[indexPath.row]
        let alerta = UIAlertController(title: "Persona seleccionada",message: nombre,preferredStyle: .alert)

        alerta.addAction(UIAlertAction(title: "Aceptar",style: .default))

        present(alerta, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

