//
//  ViewController.swift
//  Laboratorio05_Act
//
//  Created by Piero Huaytalla on 21/09/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var capitalTextField: UITextField!
    @IBOutlet weak var tasaTextField: UITextField!
    @IBOutlet weak var plazoTextField: UITextField!
    
    @IBOutlet weak var cuotaLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func calcularPrestamo(_ sender: Any) {
        let capitalTexto = capitalTextField.text?
                    .replacingOccurrences(of: ",", with: ".")

                let tasaTexto = tasaTextField.text?
                    .replacingOccurrences(of: ",", with: ".")

                let plazoTexto = plazoTextField.text?
                    .replacingOccurrences(of: ",", with: ".")

                guard
                    let capital = Double(capitalTexto ?? ""),
                    let tasaAnual = Double(tasaTexto ?? ""),
                    let años = Double(plazoTexto ?? ""),
                    capital > 0,
                    tasaAnual >= 0,
                    años > 0
                else {
                    cuotaLabel.text = "Ingrese datos válidos"
                    totalLabel.text = "Monto total: S/ 0.00"
                    return
                }

                let tasaMensual = (tasaAnual / 100) / 12
                let numeroCuotas = años * 12
                let cuotaMensual: Double

                if tasaMensual == 0 {
                    cuotaMensual = capital / numeroCuotas
                } else {
                    let factor = pow(1 + tasaMensual, numeroCuotas)

                    cuotaMensual =
                        capital * (tasaMensual * factor) / (factor - 1)
                }

                let montoTotal = cuotaMensual * numeroCuotas

                cuotaLabel.text = String(
                    format: "Cuota mensual: S/ %.2f",
                    cuotaMensual
                )

                totalLabel.text = String(
                    format: "Monto total: S/ %.2f",
                    montoTotal
                )

                view.endEditing(true)
    }
    

}

