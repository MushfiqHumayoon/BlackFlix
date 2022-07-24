//
//  ListViewController.swift
//  BlackFlix
//
//  Created by Mushfiq Humayoon on 22/07/22.
//

import UIKit

class ListViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navbarHeightConstraint: NSLayoutConstraint!

    // MARK: - Vars & Lets
    var hasNotch: Bool {
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        let bottom = keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    // MARK: Search button
    lazy var searchButton: UIBarButtonItem = {
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 50))
        let closeButton = UIButton(frame: iconSize)
        closeButton.setImage(UIImage(named: "search"), for: .normal)
        closeButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return UIBarButtonItem(customView: closeButton)
    }()
    var activityView = UIActivityIndicatorView(style: .medium)
    let padding:CGFloat = 32
    private var viewModel = ListViewModel()
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        setupBindings()
    }
    // MARK: - SubViews
    private func setupNavigationBar() {
        navbarHeightConstraint.constant = hasNotch ? 130 : 100
        self.navigationItem.rightBarButtonItem = searchButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    private func setupCollectionView() {
        let nib = UINib(nibName: CollectionViewCell.viewIdentifier(), bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.viewIdentifier())
    }

    @objc func searchButtonTapped() {
        // search actions goes here!
    }
    // MARK: - Bindings
    private func setupBindings() {
        viewModel.cellViewModels.bind { [weak self] _ in
            guard let self = self else { return }
            self.collectionView.contentInset = UIEdgeInsets(top: 36, left: 16, bottom: 16, right: 16)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
// MARK: - CollectionView Data Source
extension ListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.viewIdentifier(), for: indexPath) as? CollectionViewCell else { return CollectionViewCell() }
        let cellViewModel = viewModel.cellViewModels.value[indexPath.item]
        cell.setupCell(viewModel: cellViewModel)
        return cell
    }
}
// MARK: - CollectionView Delegate
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if collectionView.isDragging {
            guard let page = viewModel.page.value else { return }
            if page.pageSize == String(indexPath.item + 1), let pageNumber = Int(page.pageNum) {
                viewModel.buildCellViewModels(of: String(pageNumber+1))
            }
        }
    }
}
// MARK: - CollectionView Flow Layout
extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let deviceWidth = UIScreen.main.bounds.width - 64
        let cellWidth = (deviceWidth / 3)
        let size = CGSize(width: cellWidth, height: cellWidth * 1.6)
        return size
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        16
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
}
