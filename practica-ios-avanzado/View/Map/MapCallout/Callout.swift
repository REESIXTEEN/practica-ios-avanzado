//
//  Callout.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 24/2/23.
//
import UIKit
import Kingfisher

protocol MyViewDelegate {
    func detailsTapped(heroe:HeroeEntity)
}

class Callout: UIView {
    private let titleLabel = UILabel(frame: .zero)
    private let detailsButton = UIButton(configuration: UIButton.Configuration.filled())
    private let imageView = UIImageView(frame: .zero)
    private let annotation: Annotation
    var delegate: MyViewDelegate?
    
    
    init(annotation: Annotation) {
        self.annotation = annotation
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        setupTitle()
        setupImageView()
        setupButton()
    }
    
    private func setupTitle() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.text = annotation.heroe.name
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func setupImageView() {
        imageView.kf.setImage(with: URL(string: annotation.heroe.photo!))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 280).isActive = true
    }
    
    private func setupButton() {
        detailsButton.setTitle("Details", for: .normal)
        detailsButton.backgroundColor = .systemOrange
        detailsButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        addSubview(detailsButton)
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        detailsButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        detailsButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        detailsButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        detailsButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    @objc func btnTapped(){
//        let detailsView = DetailViewController()
//        detailsView.heroe = annotation.heroe
//        if let viewController = self.next as? UIViewController {
//            viewController.present(detailsView, animated: true, completion: nil)
//        }
//        navigationController?.pushViewController(detailsView, animated: true)
        delegate?.detailsTapped(heroe: annotation.heroe)
        
        
    }
}
