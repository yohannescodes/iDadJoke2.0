//
//  ViewController.swift
//  iDadJoke2.0
//
//  Created by Yohannes Haile on 2/25/24.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var savedJokeSetup = "Hello, Pheebs 👋🏾"
    var savedJokePunchline = "Are you ready for your daily dose of dad jokes?"
    
    private let setUpTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 0.3
        textView.layer.cornerRadius = 5
        textView.font = .systemFont(ofSize: 15, weight: .medium)
        textView.textAlignment = .center
        textView.textColor = .black
        textView.isEditable = false
        return textView
    }()
    
    
    private let punchLineTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 0.3
        textView.layer.cornerRadius = 5
        textView.font = .systemFont(ofSize: 15, weight: .regular)
        textView.textAlignment = .center
        textView.textColor = .black
        textView.isEditable = false
        return textView
    }()
    
    public let funBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Yep", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(named: "AccentColor")
        return button
    }()
    
    public let saveBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor(named: "AccentColor")
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpViews()
        
        self.applyConstraints()
        
    }
    
    private func setUpViews(){
        view.backgroundColor = .systemBackground
        setUpTextView.text = savedJokeSetup
        view.addSubview(setUpTextView)
        
        punchLineTextView.text = savedJokePunchline
        view.addSubview(punchLineTextView)
        funBtn.addTarget(self, action: #selector(didTapYep), for: .touchUpInside)
        view.addSubview(funBtn)
        saveBtn.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        view.addSubview(saveBtn)
    }
    
    private func applyConstraints(){
        setUpTextView.translatesAutoresizingMaskIntoConstraints = false
        punchLineTextView.translatesAutoresizingMaskIntoConstraints = false
        funBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        let setUpConstraints = [
            setUpTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            setUpTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            setUpTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            setUpTextView.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        let punchLineConstraints = [
            punchLineTextView.topAnchor.constraint(equalTo: setUpTextView.bottomAnchor, constant: 15),
            punchLineTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            punchLineTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            punchLineTextView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let funConstraints = [
            funBtn.topAnchor.constraint(equalTo: punchLineTextView.bottomAnchor, constant: 5),
            funBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            funBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let saveConstraints = [
            saveBtn.topAnchor.constraint(equalTo: punchLineTextView.bottomAnchor, constant: 5),
            saveBtn.leadingAnchor.constraint(equalTo: funBtn.trailingAnchor, constant: 5),
            saveBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            saveBtn.widthAnchor.constraint(equalToConstant: 40),
            saveBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(setUpConstraints)
        NSLayoutConstraint.activate(punchLineConstraints)
        NSLayoutConstraint.activate(funConstraints)
        NSLayoutConstraint.activate(saveConstraints)
        
    }
    
    
    private func fetchDadJoke(){
        funBtn.isEnabled = false
        funBtn.setTitle("🧘🏾", for: .normal)
        Networking.shared.getDadJoke { result in
            switch(result){
            case .success(let dadjoke):
                DispatchQueue.main.async {
                    self.setUpTextView.text = dadjoke.body[0].setup
                    self.punchLineTextView.text = dadjoke.body[0].punchline
                    self.saveBtn.isEnabled = true
                    self.saveBtn.setImage(UIImage(systemName: "heart"), for: .normal)
                    self.funBtn.isEnabled = true
                    self.funBtn.setTitle("\"Another One\"", for: .normal)
                }
            case .failure(let error):
                if(error == .responseProblem){
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Whoops", message: "It seems like you are not connected to the internet. Please try again!", preferredStyle: .alert)
                        let tryAgain = UIAlertAction(title: "Try Again", style: .default) { _ in
                            alert.resignFirstResponder()
                            self.fetchDadJoke()
                        }
                        alert.addAction(tryAgain)
                        self.present(alert, animated: true)
                    }
                }else if(error == .decodingProblem){
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Sorry", message: "John wants you to smile exactly 50 times a day 😕.", preferredStyle: .alert)
                        let notEnough = UIAlertAction(title: "That's not enough 😭.", style: .default) { _ in
                            alert.resignFirstResponder()
                        }
                        alert.addAction(notEnough)
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    private func saveDadJoke(){
        saveBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        //Saving dad joke

        let newJoke = DadJoke(context: self.context)
        newJoke.setup = setUpTextView.text
        newJoke.punchline = punchLineTextView.text
        
        do {
            try self.context.save()
            saveBtn.isEnabled = false
        }catch{
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Whoops", message: "I couldn't save your favourite joke.", preferredStyle: .alert)
                let tryAgain = UIAlertAction(title: "Try Again", style: .default) { _ in
                    self.saveDadJoke()
                    alert.resignFirstResponder()
                }
                alert.addAction(tryAgain)
                self.present(alert, animated: true)
            }

        }
    }
    
    @objc private func didTapYep(){
        self.fetchDadJoke()
    }
    
    @objc private func didTapSave(){
        self.saveDadJoke()
    }
    
    
}

