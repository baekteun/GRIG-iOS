//
//  OnboardingViewController.swift
//  OnboardingFeatureDemoApp
//
//  Created by 최형우 on 2022/05/23.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import CommonFeature
import Utility
import PaperOnboarding
import Core
import RxDataSources
import RxRelay
import ViewAnimator

protocol OnboardingPresentableListener: AnyObject {
    var displayedOnboard: BehaviorRelay<Onboard> { get }
}

final class OnboardingViewController: BaseViewController, OnboardingPresentable, OnboardingViewControllable {
    // MARK: - Properties
    private let onboardingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let bounds = UIScreen.main.bounds
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .horizontal
        lay.minimumLineSpacing = 0
        $0.isPagingEnabled = true
        $0.bounces = false
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = lay
        $0.backgroundColor = .clear
        $0.register(cellType: OnboardingCell.self)
    }
    private let frameView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 14
    }
    private let titleLabel = UILabel().then {
        $0.textColor = CoreAsset.Colors.grigOnboardMain.color
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }
    private let descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.textColor = CoreAsset.Colors.grigOnboardMain.color
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    private let nextButton = UIButton().then {
        $0.layer.cornerRadius = 31
        $0.backgroundColor = CoreAsset.Colors.grigOnboardMain.color
        $0.setImage(.init(systemName: "arrow.right")?.tintColor(.white), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    private let pageControl = UIPageControl().then {
        $0.numberOfPages = 4
        $0.pageIndicatorTintColor = CoreAsset.Colors.grigOnboardMain.color.withAlphaComponent(0.3)
        $0.currentPageIndicatorTintColor = CoreAsset.Colors.grigOnboardMain.color
        $0.currentPage = 0
    }
    private let skipButton = UIButton().then {
        $0.setImage(.init(systemName: "xmark")?.tintColor(.black), for: .normal)
    }
    
    var listener: OnboardingPresentableListener?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .init()
    }
    
    // MARK: - UI
    override func setUp() {
        onboardingCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func addView() {
        view.addSubviews(onboardingCollectionView, frameView, nextButton, skipButton)
        frameView.addSubviews(titleLabel, descriptionLabel, pageControl)
    }
    override func setLayout() {
        onboardingCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        skipButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        frameView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(bounds.height*0.394)
        }
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(50)
            $0.size.equalTo(62)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        pageControl.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.centerY.equalTo(nextButton)
        }
    }
    override func configureVC() {
        view.backgroundColor = .init(red: 1, green: 0.93, blue: 0.87, alpha: 1)
    }
    override func configureNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func bindListener() {
        let ds = RxCollectionViewSectionedReloadDataSource<OnboardingSection> { _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: OnboardingCell.self)
            cell.model = item
            return cell
        }
        
        Observable.just([
            CoreAsset.Images.grigOnboard1.image,
            CoreAsset.Images.grigOnboard2.image,
            CoreAsset.Images.grigOnboard3.image,
            CoreAsset.Images.grigOnboard4.image
        ])
        .map { [OnboardingSection.init(items: $0)] }
        .bind(to: onboardingCollectionView.rx.items(dataSource: ds))
        .disposed(by: disposeBag)
        
        listener?.displayedOnboard
            .distinctUntilChanged()
            .bind(with: self, onNext: { owner, onboard in
                owner.titleLabel.text = onboard.titleDisplay
                owner.descriptionLabel.text = onboard.descriptionDisplay
                owner.nextButton.setTitle(onboard == .sort ? "시작하기" : nil, for: .normal)
                UIView.animate(withDuration: 0.5) {
                    if onboard == .sort {
                        owner.nextButton.snp.updateConstraints {
                            $0.width.equalTo(150)
                        }
                    } else {
                        owner.nextButton.snp.updateConstraints {
                            $0.width.equalTo(62)
                        }
                    }
                    owner.nextButton.superview?.layoutIfNeeded()
                }
                
                
            })
            .disposed(by: disposeBag)
    }
}

extension OnboardingViewController {
    var nextpageTrigger: Observable<Int> {
        onboardingCollectionView.rx.didScroll
            .withUnretained(self)
            .compactMap { owner, _ in
                let width = owner.onboardingCollectionView.frame.width
                guard
                    !width.isNaN && !width.isInfinite && width != 0
                else {
                    return 0
                }
                let index = Int(owner.onboardingCollectionView.contentOffset.x / width)
                owner.pageControl.currentPage = index
                return index
            }
    }
    var xButtonTrigger: Observable<Void> {
        skipButton.rx.tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.asyncInstance)
            .asObservable()
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width, height: bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
    }
}
