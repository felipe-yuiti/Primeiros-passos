import UIKit

//let numeros = [9, 9.9, 9, 9.9]
//
//func calculo(numeros: [Double]) -> Double{
//    var total: Double = 0
//    for numero in numeros {
//        total -= numero
//    }
//    return total
//}
//
//calculo(numeros: numeros)
import UIKit

import UIKit

class Refeicao {
    var nome: String
    var felicidade: String
    var itens: Array<Item> = []

    init(nome: String, felicidade: String) {
        self.nome = nome
        self.felicidade = felicidade
    }
    func totalDeCalorias() -> Double {
        var total = 0.0

        for item in itens {
            total += item.calorias
        }

        return total
    }
}

class Item {
    var nome: String
    var calorias: Double

    init(nome: String, calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }
}

let arroz = Item(nome: "Arroz", calorias: 51.0)
let feijao = Item(nome: "Feijão", calorias: 90.0)
let contraFile = Item(nome: "Contra Filé", calorias: 287.0)

let refeicao = Refeicao(nome: "Almoço", felicidade: "5")

refeicao.itens.append(arroz)
refeicao.itens.append(feijao)
refeicao.itens.append(contraFile)

if let verifica = refeicao.itens.first{
    print(verifica.nome)
}
print(refeicao.totalDeCalorias())

