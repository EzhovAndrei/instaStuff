//
//  SliderEditModuleController.swift
//  InstaStuff
//
//  Created by aezhov on 19/06/2019.
//  Copyright © 2019 Андрей Ежов. All rights reserved.
//

import UIKit

/// Контроллер для экрана «SliderEditModule»
final class BaseEditModuleController: BaseViewController<BaseEditModulePresentable>, BaseEditModuleDisplayable {

    // MARK: - Properties
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(toTopButton)
        stackView.addArrangedSubview(toBackgroundButton)
        return stackView
    }()
    
    private lazy var toTopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "moveToFront"), for: .normal)
        return button
    }()
    
    private lazy var toBackgroundButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "moveToBack"), for: .normal)
        return button
    }()

    // MARK: - Life Cycle

    override func updateViewConstraints() {
        stackView.snp.remakeConstraints { maker in
            maker.edges.equalToSuperview().inset(12)
        }
        super.updateViewConstraints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - BaseEditModuleDisplayable
    
    // MARK: - Private Functions
    
    private func setup() {
        view.addSubview(stackView)
        setupActions(for: presenter.baseEditHandler)
    }
    
    private func setupActions(for target: BaseEditProtocol) {
        toTopButton.addTarget(target, action: #selector(BaseEditProtocol.moveToFront), for: .touchUpInside)
        toBackgroundButton.addTarget(target, action: #selector(BaseEditProtocol.moveToBack), for: .touchUpInside)
    }
    
    // MARK: - Functions
    

}