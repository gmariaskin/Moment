//
//  GuidelinesView.swift
//  HiddenCamera
//
//  Created by DiOS on 30.10.2023.
//

import UIKit

enum GuidelinesState {
    case privacyPolicy
    case termsOfUse
}

class GuidelinesView: UIView {
    
    private let containerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .clear
        obj.layer.cornerRadius = 16
        return obj
    }()

    let textView: UITextView = {
        let obj = UITextView()
        obj.textColor = .black
        obj.font = .systemFont(ofSize: 17, weight: .regular)
        obj.backgroundColor = .clear
        obj.contentInset = .init(top: 16, left: 10, bottom: 16, right: 10)
        obj.layoutMargins = .init(top: 16, left: 10, bottom: 16, right: 10)
        return obj
    }()

    init(state: GuidelinesState) {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        
        self.textView.isEditable = false

        addSubview(containerView)
        containerView.addSubview(textView)

        containerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureText(with text: NSAttributedString) {
        self.textView.attributedText = text
        self.textView.scrollRangeToVisible(NSMakeRange(0, 0))
        self.textView.textContainerInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
}
