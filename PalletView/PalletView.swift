//
//  PalletView.swift
//  Pallet
//
//  Created by Nikolay Kargin on 21/01/2024.
//

import UIKit

final class PalletView: UIView {
    
    var contentView: UIView {
        label
    }
    
    private let standardVisualEffect = UIBlurEffect(style: .systemThinMaterial)
    
    private let visualEffectView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        view.backgroundColor = navigationBarAppearance.shadowColor
        
        return view
    }()
    
    private let label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .systemFont(ofSize: UIFont.smallSystemFontSize)
        view.textColor = .secondaryLabel
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        label.text = "Subtitle"
        
        addSubview(visualEffectView)
        addSubview(label)
        addSubview(shadowView)
        NSLayoutConstraint.activate([
            visualEffectView.leftAnchor.constraint(equalTo: leftAnchor),
            visualEffectView.topAnchor.constraint(equalTo: topAnchor),
            visualEffectView.rightAnchor.constraint(equalTo: rightAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0.0),
            contentView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0.0),
            bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 8.0),
            
            shadowView.leftAnchor.constraint(equalTo: leftAnchor),
            shadowView.rightAnchor.constraint(equalTo: rightAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shadowView.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale),
        ])
    }
    
    func scrollEdgeAppearance() {
        shadowView.alpha = 0.0
        visualEffectView.effect = nil
    }
    
    func standardAppearance() {
        shadowView.alpha = 1.0
        visualEffectView.effect = standardVisualEffect
    }
    
}

