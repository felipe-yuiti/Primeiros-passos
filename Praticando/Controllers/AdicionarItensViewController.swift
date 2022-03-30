//
//  AdicionarItensViewController.swift
//  Praticando
//
//  Created by Felipe Yuiti on 21/03/22.
//

import UIKit

protocol AdicionaItensDelegate {
    func add(_ item:Item)
}

class AdicionarItensViewController: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var nomeItemTextLabel: UITextField?
    @IBOutlet weak var caloriasItemTextLabel: UITextField?
    
    //MARK: - Atributos
    
    var delegate: AdicionaItensDelegate?
    
    init(delegate: AdicionaItensDelegate){
        super.init(nibName: "AdicionarItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - IBAction
    
    @IBAction func adicionarItem(_ sender: Any) {
        
        guard let nomeItem = nomeItemTextLabel?.text, let calorias = caloriasItemTextLabel?.text else {return}
        if let numeroDeCalorias = Double(calorias){
            let item = Item(nome: nomeItem, calorias: numeroDeCalorias)
            delegate?.add(item)
            //navegar para proxima tela: navigationController.push(), puxar o view controller
            //voltar para tela anterior: navigationController.pop(), voltar para tela anterior
            navigationController?.popViewController(animated: true)
        }
    }
    //MARK: - IBOutlets
}
