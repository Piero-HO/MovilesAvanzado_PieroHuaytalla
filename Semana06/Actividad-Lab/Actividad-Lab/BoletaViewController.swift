//
//  BoletaViewController.swift
//  Actividad-Lab
//
//  Created by Piero Huaytalla on 7/10/26.
//

import UIKit

class BoletaViewController: UIViewController {

    var carrito: CarritoModel!
    var cliente: ClienteModel!

    @IBOutlet weak var boletaTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        boletaTextView.text = carrito.boleta(cliente: cliente)
        boletaTextView.font = UIFont.monospacedSystemFont(ofSize: 14, weight: .regular)
        // Se conserva el texto de la boleta antes de vaciar el carrito compartido.
        carrito.confirmarCompra()
    }

    
    @IBAction func cerrarTapped(_ sender: UIButton) {
        let navegacion = presentingViewController as? UINavigationController
        dismiss(animated: true) {
            navegacion?.popToRootViewController(animated: true)
        }
    }
    
}
