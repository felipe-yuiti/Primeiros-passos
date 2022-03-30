import UIKit

protocol AdicionaRefeicoesDelegate{
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate, AdicionaItensDelegate{
    
    // MARK: - ATRIBUTOS
    var delegate: AdicionaRefeicoesDelegate?
    
    var itens: [Item] = []
    
    var itensSelecionados: [Item] = []
    
    // MARK: - IBOutlet
    @IBOutlet weak var nomeTextField: UITextField?
    
    @IBOutlet weak var felicidadeTextField: UITextField?
    
    @IBOutlet weak var itensTableView: UITableView!
    
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "adicionar", style: .plain, target: self, action: #selector(AdicionarItem))
        navigationItem.rightBarButtonItem = botaoAdicionaItem
        recuperaItens()
    }
    func recuperaItens(){
        itens = ItemDao().recupera()
    }
    
    @objc func AdicionarItem(){
        let AdicionarItensViewController = AdicionarItensViewController(delegate: self)
        //pegamos a primeira tela navigationcontroller e chamamos pelo metodo push
        navigationController?.pushViewController(AdicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        ItemDao().save(itens)
        if let tableView = itensTableView{
            tableView.reloadData()
        }else {
            Alerta(controller: self).exibe(titulo: "Desculpe", mesagem: "Não foi possivel atualizar a tabela")
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let linhaDaTabela = indexPath.row
        let item = itens[linhaDaTabela]
        
        cell.textLabel?.text = item.nome
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        if cell.accessoryType == .none{
            cell.accessoryType = .checkmark
            let linhaDaTabela = indexPath.row
            itensSelecionados.append(itens[linhaDaTabela])
        } else{
            cell.accessoryType = .none
            // nao existe metodo que remova o objeto item
            let item = itens[indexPath.row]
            if let position = itensSelecionados.firstIndex(of: item){
                itensSelecionados.remove(at: position)
                
                for itemSelecionados in itensSelecionados{
                    print(itemSelecionados.nome)
                }
            }
        }
    }
    func recuperaRefeicaoDoFormulario() -> Refeicao?{
        guard let nomeDaRefeicao = nomeTextField?.text else {return nil}
        guard let felicidadeDaRefeicao = felicidadeTextField?.text,
              let felicidade = Int(felicidadeDaRefeicao) else {return nil}
        
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itensSelecionados)
        return refeicao
    }
    
    // MARK: - IBAction
    @IBAction func adicionar(_ sender: Any) {
        if let refeicao = recuperaRefeicaoDoFormulario(){
            delegate?.add(refeicao)
            navigationController?.popViewController(animated: true)}
        else{
            Alerta(controller: self).exibe(mesagem: "Erro ao ler dados do formulário")}
    }
}
