//
//  DetalleViewController.swift
//  Actividad-Lab
//
//  Created by Piero Huaytalla on 7/10/26.
//

import UIKit

class DetalleViewController: UIViewController {

    var producto: Producto!
    var carrito: CarritoModel!

    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var cantidadTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nombreLabel.text = producto.nombre
        precioLabel.text = String(format: "Precio: S/ %.2f", producto.precio)
        stockLabel.text = "Stock: \(producto.stock)"
        cantidadTextField.text = "1"
        let toque = UITapGestureRecognizer(target: self, action: #selector(ocultarTeclado))
        toque.cancelsTouchesInView = false
        view.addGestureRecognizer(toque)
    }

    @objc private func ocultarTeclado() {
        view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func agregarTapped(_ sender: UIButton) {
        let texto = (cantidadTextField.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        if let cantidad = Int(texto), cantidad > 0 {
            if carrito.agregar(producto: producto, cantidad: cantidad) {
                view.endEditing(true)
                navigationController?.popViewController(animated: true)
            } else {
                mostrarAlerta(
                    mensaje: "Stock insuficiente. Considera también las unidades que ya están en el carrito."
                )
            }
        } else {
            mostrarAlerta(mensaje: "Ingresa una cantidad entera mayor que cero.")
        }
    }

    private func mostrarAlerta(mensaje: String) {
        let alerta = UIAlertController(
            title: "No se pudo agregar",
            message: mensaje,
            preferredStyle: .alert
        )
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alerta, animated: true)
    }
}
