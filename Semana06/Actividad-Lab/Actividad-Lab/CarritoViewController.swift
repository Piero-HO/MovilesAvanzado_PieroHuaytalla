//
//  CarritoViewController.swift
//  Actividad-Lab
//
//  Created by Piero Huaytalla on 7/10/26.
//

import UIKit

class CarritoViewController: UIViewController {

    var carrito: CarritoModel!

    @IBOutlet weak var itemsTextView: UITextView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var descuentoLabel: UILabel!
    @IBOutlet weak var igvLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var categoriaLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func continuarTapped(_ sender: UIButton) {
        if carrito.items.isEmpty {
            let alerta = UIAlertController(
                title: "Carrito vacío",
                message: "Agrega un producto antes de continuar.",
                preferredStyle: .alert
            )
            alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
            present(alerta, animated: true)
            return
        }

        performSegue(withIdentifier: "irDatosCliente", sender: sender)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        var detalle = ""
        for item in carrito.items {
            detalle += "\(item.producto.nombre) x\(item.cantidad) "
            detalle += String(format: "S/ %.2f\n", item.subtotal())
        }

        itemsTextView.text = carrito.items.isEmpty ? "Carrito vacío" : detalle
        subtotalLabel.text = String(format: "Subtotal: S/ %.2f", carrito.subtotal())
        descuentoLabel.text = String(
            format: "Descuento (%.0f%%): -S/ %.2f",
            carrito.porcentajeDescuento() * 100,
            carrito.descuento()
        )
        igvLabel.text = String(format: "IGV: S/ %.2f", carrito.igv())
        totalLabel.text = String(format: "Total: S/ %.2f", carrito.total())
        categoriaLabel.text = "Categoría: \(carrito.categoria())"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irDatosCliente" {
            let destino = segue.destination as! DatosClienteViewController
            destino.carrito = carrito
        }
    }
}
