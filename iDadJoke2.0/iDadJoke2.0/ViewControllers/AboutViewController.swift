//
//  SettingsViewController.swift
//  iDadJoke2.0
//
//  Created by Yohannes Haile on 2/25/24.
//

import UIKit

class AboutViewController: UIViewController {
    
    let aboutText = """
        That's when iDadJoke came to development. iDadJoke is an app that lets you smile and have fun with your daily dose of dad jokes. The app fetches dad jokes from an API and lets you see up to 50 jokes in 24 hours. 
"""
    
    private let aboutTextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 0.3
        textView.layer.cornerRadius = 5
        textView.font = .systemFont(ofSize: 15, weight: .medium)
        textView.textAlignment = .justified
        textView.textColor = .black
        textView.isEditable = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpViews()
        applyConstraints()
    }
    
    private func setUpViews(){
        view.backgroundColor = .systemBackground
        aboutTextView.text = aboutText
        view.addSubview(aboutTextView)
    }
    
    private func applyConstraints(){
        aboutTextView.translatesAutoresizingMaskIntoConstraints = false
        
        let aboutConstraints = [
            aboutTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            aboutTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            aboutTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            aboutTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(aboutConstraints)
        
    }
    
}
