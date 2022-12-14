//
//  ViewController.swift
//  PictureGS
//
//  Created by Игорь Иванюков on 24.11.2022.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadMoreButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images: [Image] = [Image]()
    var itemsArray: [Image] = [Image]()
    var isLoading = false
    var page = 0
    var start = 0
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "MainCVC", bundle: nil), forCellWithReuseIdentifier: MainCVC.reuseId)
        
        collectionView.allowsMultipleSelection = true
        
        loadData()
    }
    
    func loadData() {
        isLoading = false
        collectionView.collectionViewLayout.invalidateLayout()
        for i in 0...19 {
            if !images.isEmpty {
                itemsArray.append(images[i])
            } else { return }
        }
        self.collectionView.reloadData()
    }
    
    func toSearch (text: String, page: Int) {
        
        APICaller.shared.search(with: text.capitalizeFirstLetter(), page: page) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.images = image
//                    self?.loadMoreData()
                    self?.loadData()
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    @IBAction func toSettingsSearch(_ sender: Any) {
        
        let settingVC = SettingsSearchVC()
        settingVC.modalPresentationStyle = .fullScreen
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "PictureGS", style: .done, target: nil, action: nil)
        show(settingVC, sender: nil)
    }
    
    @IBAction func loadMoreButtonTap(_ sender: Any) {
        
        loadMoreButtonClick()
    }
    
    func loadMoreButtonClick () {
        if itemsArray.count % 100 == 0 {
            start = 0
            page += 1
            images.removeAll()
            self.toSearch(text: text, page: page)
            loadData()
        } else { start += 20
        loadMoreData()
        }
        loadMoreButton.isHidden = true
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            loadMoreData()
            let end = start + 19
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
                for i in self.start...end {
                    self.itemsArray.append(self.images[i])
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
    
}

extension MainVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailsVC = DetailsVC()
        detailsVC.imagesModel = itemsArray
        detailsVC.position = itemsArray[indexPath.item].position - 1
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "PictureGS", style: .done, target: nil, action: nil)
        show(detailsVC, sender: nil)
    }

}

extension MainVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemsArray.count
//        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        print(itemsArray.count % 100)
        if indexPath.row == itemsArray.count - 2, !self.isLoading {
            loadMoreButton.isHidden = false
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCVC.reuseId, for: indexPath) as? MainCVC else { return UICollectionViewCell() }
        if !itemsArray.isEmpty {
            cell.configure(with: itemsArray[indexPath.item].thumbnail ?? "")
        }
        return cell
    }
    
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
}

extension MainVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText != "" || searchText != " " else { return }
        if searchText.count >= 5 {
            self.toSearch(text: searchText, page: page)
            self.text = searchText
            print(searchText)
        }
    }
}

