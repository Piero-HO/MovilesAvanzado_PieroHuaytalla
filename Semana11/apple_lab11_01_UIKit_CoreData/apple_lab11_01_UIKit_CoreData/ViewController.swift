//
//  ViewController.swift
//  apple_lab11_01_UIKit_CoreData
//
//  Created by Piero Huaytalla on 4/11/26.
//

import UIKit
import CoreData

class ViewController: UIViewController,
                      UITableViewDelegate,
                      UITableViewDataSource {
    
    @IBOutlet weak var TablaContacto: UITableView!
    
    var contactos = [Contacto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TablaContacto.dataSource = self
        TablaContacto.delegate = self
        
        mostrarRutaBaseDeDatos()
        cargarInfoCoreData()
    }
    
    func conexion() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    func mostrarRutaBaseDeDatos() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let ruta = delegate.persistentContainer
            .persistentStoreDescriptions.first?.url?.path ?? "sin ruta"
        
        print("Base de datos SQLite en: \(ruta)")
    }
    
    func cargarInfoCoreData() {
        let request: NSFetchRequest<Contacto> = Contacto.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "nombre", ascending: true)
        ]
        
        do {
            contactos = try conexion().fetch(request)
        } catch {
            print("Error al cargar la BD: \(error)")
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return contactos.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        )
        
        let contacto = contactos[indexPath.row]
        celda.textLabel?.text = contacto.nombre
        celda.detailTextLabel?.text =
        "\(contacto.telefono ?? "") | \(contacto.direccion ?? "")"
        
        return celda
    }
    // MARK: - CREATE: agregar un contacto
    // Acción vinculada al Bar Button Item (+)
    @IBAction func agregarContacto(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Agregar Contacto", message: "Nuevo Contacto", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Nombre" }
        alert.addTextField { $0.placeholder = "Telefono" }
        alert.addTextField { $0.placeholder = "Direccion" }
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style: .default) { _ in
            guard let nombre = alert.textFields?[0].text, !nombre.isEmpty else { return }
            let telefono = alert.textFields?[1].text ?? ""
            let direccion = alert.textFields?[2].text ?? ""
            let contexto = self.conexion()
            
            // Crea un nuevo objeto en el contexto; aún no está guardado.
            let entidad = NSEntityDescription.insertNewObject(forEntityName: "Contacto", into: contexto) as! Contacto
            entidad.nombre = nombre
            entidad.telefono = telefono
            entidad.direccion = direccion
            
            do {
                try contexto.save()
                self.cargarInfoCoreData()
                self.TablaContacto.reloadData()
            } catch {
                print("Error al guardar el dato: \(error)")
            }
        }
        alert.addAction(actionAceptar)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }
}
