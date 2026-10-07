//
//  DatosClienteViewController.swift
//  Actividad-Lab
//
//  Created by Piero Huaytalla on 7/10/26.
//

import UIKit

class DatosClienteViewController: UIViewController {

    var carrito: CarritoModel!
    var cliente: ClienteModel?

    @IBOutlet weak var nombresTextField: UITextField!
    @IBOutlet weak var apellidosTextField: UITextField!
    @IBOutlet weak var dniTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let toque = UITapGestureRecognizer(target: self, action: #selector(ocultarTeclado))
        toque.cancelsTouchesInView = false
        view.addGestureRecognizer(toque)
    }

    @objc private func ocultarTeclado() {
        view.endEditing(true)
    }
    
    @IBAction func confirmarCompraTapped(_ sender: UIButton) {
        let nombres = (nombresTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let apellidos = (apellidosTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let dni = (dniTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        if nombres.isEmpty || apellidos.isEmpty || dni.isEmpty {
            mostrarAlerta(mensaje: "Completa nombres, apellidos y DNI.")
            return
        }

        if dni.count != 8 || !dni.allSatisfy({ "0123456789".contains($0) }) {
            mostrarAlerta(mensaje: "El DNI debe tener exactamente 8 dígitos.")
            return
        }

        if carrito.items.isEmpty {
            mostrarAlerta(mensaje: "El carrito está vacío. Agrega un producto.")
            return
        }

        for item in carrito.items {
            if item.cantidad > item.producto.stock {
                mostrarAlerta(mensaje: "Stock insuficiente para \(item.producto.nombre).")
                return
            }
        }

        cliente = ClienteModel(nombres: nombres, apellidos: apellidos, dni: dni)
        view.endEditing(true)
        performSegue(withIdentifier: "verBoleta", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verBoleta" {
            let destino = segue.destination as! BoletaViewController
            destino.carrito = carrito
            destino.cliente = cliente
        }
    }

    private func mostrarAlerta(mensaje: String) {
        let alerta = UIAlertController(
            title: "Revisa los datos",
            message: mensaje,
            preferredStyle: .alert
        )
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alerta, animated: true)
    }
    
    

}
