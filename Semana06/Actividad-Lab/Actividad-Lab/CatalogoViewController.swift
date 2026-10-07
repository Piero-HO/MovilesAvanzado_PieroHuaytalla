//
//  CatalogoViewController.swift
//  Actividad-Lab
//
//  Created by Piero Huaytalla on 7/10/26.
//

import UIKit

class CatalogoViewController: UIViewController {

    let productos: [Producto] = [
        Producto(nombre: "Refrigeradora", precio: 2000, stock: 5),
        Producto(nombre: "Licuadora", precio: 250, stock: 10),
        Producto(nombre: "Laptop", precio: 3500, stock: 3),
        Producto(nombre: "Cocina", precio: 1200, stock: 4),
        Producto(nombre: "Microondas", precio: 450, stock: 6)
    ]

    // Prueba final: 1 cambio en Storyboard (un botón con Tag 4 conectado a
    // productoTapped) y 1 cambio en código (añadir Microondas al array).
    // Se mantiene un único segue verDetalle y la misma acción para todos.
    // PREDICT 1: el carrito es el mismo objeto, creado únicamente en Catálogo.
    // PREDICT 2: con struct, Detalle recibiría una copia y sus cambios no se
    // reflejarían en el carrito de Catálogo sin devolver el valor actualizado.

    // El carrito se crea una sola vez, aquí.
    let carrito = CarritoModel()

    @IBOutlet weak var verCarritoButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func productoTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "verDetalle", sender: sender)
    }
    @IBAction func verCarritoTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "verCarrito", sender: sender)
    }

    // B2: actualizar el botón cada vez que se vuelve al Catálogo.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        verCarritoButton.setTitle(
            "Ver carrito (\(carrito.cantidadTotal()))",
            for: .normal
        )
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verDetalle" {
            let boton = sender as! UIButton
            let destino = segue.destination as! DetalleViewController
            destino.producto = productos[boton.tag]
            destino.carrito = carrito
        }

        // B1: pasar el mismo carrito a la pantalla Carrito.
        if segue.identifier == "verCarrito" {
            let destino = segue.destination as! CarritoViewController
            destino.carrito = carrito
        }
    }
    
}
