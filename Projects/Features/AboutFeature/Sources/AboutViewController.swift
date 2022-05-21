//
//  AboutViewController.swift
//  AboutFeature
//
//  Created by 최형우 on 2022/05/02.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import CDMarkdownKit
import Then
import Utility
import CommonFeature
import SnapKit
import Core
import MessageUI

protocol AboutPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class AboutViewController: BaseViewController, AboutPresentable, AboutViewControllable {
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let purposeLabel = AboutView(about: .purpose)
    private let functionLabel = AboutView(about: .funtion)
    private let issueLabel = AboutView(about: .issue)
    private let licenseLabel = AboutView(about: .license)
    private let privacyLabel = AboutView(about: .privacy)
    private let labelStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 30
    }
    private let titleView = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
        let str = NSMutableAttributedString(string: "프로젝트에 관하여")
        str.setColorForText(textToFind: "프로젝트", withColor: .init(red: 1, green: 0.717, blue: 0.184, alpha: 1))
        $0.attributedText = str
    }
    private let mailButton = UIBarButtonItem(image: .init(systemName: "envelope")?.tintColor(CoreAsset.Colors.grigPrimaryTextColor.color), style: .plain, target: nil, action: nil)

    weak var listener: AboutPresentableListener?
    
    // MARK: - UI
    override func addView() {
        labelStack.addArrangeSubviews(purposeLabel, functionLabel, issueLabel, licenseLabel, privacyLabel)
        scrollView.addSubviews(labelStack)
        view.addSubviews(scrollView)
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        labelStack.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.width.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalToSuperview()
        }
    }
    override func configureVC() {
        view.backgroundColor = CoreAsset.Colors.grigWhite.color
    }
    override func configureNavigation() {
        self.navigationItem.titleView = self.titleView
        self.navigationItem.setRightBarButton(mailButton, animated: true)
    }
    
    override func bindListener() {
        
    }
    
    func presentMailScene() {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.delegate = self
            
            composeVC.setToRecipients(["baegteun@gmail.com"])
            composeVC.setSubject("앱 피드백")
            composeVC.setMessageBody("""
OS Version: \(UIDevice.current.systemVersion)
Device model: \(UIDevice.current.model)
내용을 입력해주세요!

""", isHTML: false)
            self.topViewControllable.uiviewController.present(composeVC, animated: true, completion: nil)
        } else {
            self.topViewControllable.presentFailureAlert(title: "메일 전송이 실패했습니다.", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", style: .alert)
        }
    }
}

extension AboutViewController: MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension AboutViewController {
    var viewDidDisAppearTrigger: Observable<Void> {
        self.rx.viewDidDisAppear.asObservable()
    }
    var mailDidTap: Observable<Void> {
        self.mailButton.rx.tap.asObservable()
    }
}
