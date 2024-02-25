//
//  SavedViewController.swift
//  iDadJoke2.0
//
//  Created by Yohannes Haile on 2/25/24.
//

import UIKit

class SavedViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var jokes: [DadJoke]?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchJokes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchJokes(){
        do{
            self.jokes = try context.fetch(DadJoke.fetchRequest())
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }catch{
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Whoops", message: "I couldn't get your favourite jokes for the moment.", preferredStyle: .alert)
                let tryAgain = UIAlertAction(title: "Try Again", style: .default) { _ in
                    self.fetchJokes()
                    alert.resignFirstResponder()
                }
                
                alert.addAction(tryAgain)
                self.present(alert, animated: true)
            }
        }
    }
    
    private func showDadJoke(index: Int){
        let savedJokeVC = HomeViewController()
        savedJokeVC.savedJokeSetup = jokes?[index].setup ?? "Hello, Pheebs 👋🏾"
        savedJokeVC.savedJokePunchline = jokes?[index].punchline ?? "Are you ready for your daily dose of dad jokes?"
        savedJokeVC.funBtn.setTitle("Another One", for: .normal)
        savedJokeVC.saveBtn.isEnabled = false
        savedJokeVC.saveBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        navigationController?.pushViewController(savedJokeVC, animated: true)
    }
}

extension SavedViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = jokes?[indexPath.row].setup
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDadJoke(index: indexPath.row)
    }
    
}
