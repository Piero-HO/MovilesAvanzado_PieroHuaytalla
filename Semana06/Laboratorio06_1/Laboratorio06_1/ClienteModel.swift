//
//  ClienteModel.swift
//  Laboratorio06_1
//
//  Created by Piero Huaytalla on 30/09/26.
//

import UIKit

class ClienteModel: NSObject {
    var Codigo: Int32 = 0
    var Apellido: String = ""
    var Nombre: String = ""
    var Dni: String = ""
    
    override init() {
        self.Codigo = 0
        self.Apellido = ""
        self.Nombre = ""
        self.Dni = ""
    }
    init(pCodigo:Int32,pApellido:String,pNombre:String,pDni:String)
    {
        self.Codigo = pCodigo
        self.Apellido = pApellido
        self.Nombre = pNombre
        self.Dni = pDni
    }
}
