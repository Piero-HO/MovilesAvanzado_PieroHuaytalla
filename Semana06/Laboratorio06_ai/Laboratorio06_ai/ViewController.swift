//
//  ViewController.swift
//  Laboratorio06_ai
//
//  Created by Piero Huaytalla on 30/09/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfElectrodomestico: UITextField!
    @IBOutlet weak var tfPrecio: UITextField!
    @IBOutlet weak var tfCantidad: UITextField!
    @IBOutlet weak var tfMeses: UITextField!
    @IBOutlet weak var tfInteres: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(
            for segue: UIStoryboardSegue,
            sender: Any?
        ) {
            guard
                segue.identifier == "showResultado",
                let destino = segue.destination
                    as? ResultadoViewController
            else {
                return
            }

            let precio = Double(
                tfPrecio.text?
                    .replacingOccurrences(of: ",", with: ".")
                    ?? ""
            ) ?? 0

            let cantidad = Double(tfCantidad.text ?? "") ?? 0
            let meses = Double(tfMeses.text ?? "") ?? 1

            let tasaInteres = Double(
                tfInteres.text?
                    .replacingOccurrences(of: ",", with: ".")
                    ?? ""
            ) ?? 0

            let subtotal = precio * cantidad
            let igv = subtotal * 0.18
            let base = subtotal + igv

            let intereses =
                base * (tasaInteres / 100) * meses

            let total = base + intereses
            let cuota = total / meses

            destino.venta = VentaModel(
                subtotal: subtotal,
                igv: igv,
                base: base,
                intereses: intereses,
                total: total,
                cuota: cuota
            )
        }
}
