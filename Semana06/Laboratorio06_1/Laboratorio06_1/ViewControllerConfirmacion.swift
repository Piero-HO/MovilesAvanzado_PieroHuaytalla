//
//  ViewControllerConfirmacion.swift
//  Laboratorio06_1
//
//  Created by Piero Huaytalla on 30/09/26.
//

import UIKit

class ViewControllerConfirmacion: UIViewController {
    var pCliente: ClienteModel =
        ClienteModel()
    @IBOutlet weak var tfApellido: UILabel!
    @IBOutlet weak var tfNombre: UILabel!
    @IBOutlet weak var tfDni: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tfApellido.text = pCliente.Apellido
        self.tfNombre.text = pCliente.Nombre
        self.tfDni.text = pCliente.Dni
    }

}
