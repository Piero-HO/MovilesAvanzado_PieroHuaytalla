//
//  ViewController.swift
//  Laboratorio05_2
//
//  Created by Piero Huaytalla on 16/09/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pesoTextField: UITextField!
    @IBOutlet weak var alturaTextField: UITextField!
    @IBOutlet weak var resultadoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func calcularIMC(_ sender: UIButton) {
        guard
                    let pesoTexto = pesoTextField.text?
                        .replacingOccurrences(of: ",", with: "."),
                    let alturaTexto = alturaTextField.text?
                        .replacingOccurrences(of: ",", with: "."),
                    let peso = Double(pesoTexto),
                    let altura = Double(alturaTexto),
                    peso > 0,
                    altura > 0
                else {
                    resultadoLabel.text = "Ingrese datos válidos"
                    return
                }

                let imc = peso / (altura * altura)
                let estado: String

                if imc < 18.5 {
                    estado = "Bajo peso"
                } else if imc < 25 {
                    estado = "Peso normal"
                } else if imc < 30 {
                    estado = "Sobrepeso"
                } else {
                    estado = "Obesidad"
                }
                resultadoLabel.text =
                    String(format: "IMC: %.2f - %@", imc, estado)
    }
}

