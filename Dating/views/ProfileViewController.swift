//
//  ProfileViewController.swift
//  Dating
//
//  Created by Ty Pham on 7/5/20.
//  Copyright © 2020 Ty Pham. All rights reserved.
//

import UIKit
import Lottie
import SDWebImage

enum ProfileSection: Int {
    case HorizontalImages = 0
    case Info = 1
}

class ProfileViewController: UIViewController {
    
    // MARK: default values
    let pageImagesCell = "PageImagesCollectionViewCell"
    let mainMomentPictureCell = "MainMomentPictureCollectionViewCell"
    let momentPictureCell = "MomentPictureCollectionViewCell"
    let infoCell = "InfoCollectionViewCell"
    
    let estimateCellSize = CGSize(width: 50, height: 50)
    let horizontalCellRatio:CGFloat = 375.0 / 350.0
    let pageControlHeight:CGFloat = 30.0
    
    private var viewModel:ProfileViewModel!
    
    // MARK: UI elements
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIView!
    
    /// headers
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    /// animation button
    @IBOutlet weak var buttonContainerView: UIView!
    var animateView: AnimationView!
    
    // MARK: view life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// init view model
        viewModel = ProfileViewModel(delegate: self)
        
        /// init collection view
        initCollectionView()
        
        /// init animation button
        animateView = .init(name: "heartbeat")
        animateView.contentMode = .scaleAspectFill
        animateView.frame = self.buttonContainerView.bounds
        animateView.backgroundBehavior = .pauseAndRestore
        animateView.loopMode = .loop
        buttonContainerView.addSubview(animateView)
        
        /// add gesture for animation button
        let singleTap = UITapGestureRecognizer(target: self, action:#selector(likeButtonTapped(_:)))
        singleTap.numberOfTapsRequired = 1
        buttonContainerView.addGestureRecognizer(singleTap)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        /// decorate UI for header view
        decorateHeaderView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: initialize
    
    /// Init values collection view
    ///
    /// - Parameter none
    /// - Returns: none
    func initCollectionView () {
        /// set estimateCellSize
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
           flowLayout.estimatedItemSize = estimateCellSize
        }
        
        /// register PageImage cell
        let pageImagesNib = UINib(nibName: pageImagesCell, bundle: nil)
        collectionView.register(pageImagesNib, forCellWithReuseIdentifier: pageImagesCell)
        
        /// register MainMomentPicture cell
        let mainMomentNib = UINib(nibName: mainMomentPictureCell, bundle: nil)
        collectionView.register(mainMomentNib, forCellWithReuseIdentifier: mainMomentPictureCell)
        
        /// register MomentPicture cell
        let momentNib = UINib(nibName: momentPictureCell, bundle: nil)
        collectionView.register(momentNib, forCellWithReuseIdentifier: momentPictureCell)
        
        /// register Info cell
        let infoNib = UINib(nibName: infoCell, bundle: nil)
        collectionView.register(infoNib, forCellWithReuseIdentifier: infoCell)
    }
    
    /// Init values of header view
    ///
    /// - Parameter none
    /// - Returns: none
    func decorateHeaderView() {
        /// header container view
        headerContainerView.layer.masksToBounds = false
        headerContainerView.layer.shadowRadius = 1
        headerContainerView.layer.shadowOpacity = 1
        headerContainerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerContainerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        
        /// avatar
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.layer.masksToBounds = true
    }
    
    /// Update info of header view
    ///
    /// - Parameter none
    /// - Returns: none
    func updateHeaderInfo() {
        nameLabel.text = viewModel.getUsername()
    
        profileImage.sd_setImage(with: URL(string: viewModel.profileAvatarImageUrl()),
                                 placeholderImage: UIImage(named: "Profile"))
        
        /// update animation state of button like
        updateLikeButtonAnimation(level: viewModel.getLikeLevel())
    }
    
    /// update LikeButton Animation
    ///
    /// - Parameter level: How much do you like
    /// - Returns: none
    func updateLikeButtonAnimation(level:Int) {
        if level > 0{
            animateView.play()
        }else {
            animateView.stop()
        }
    }
    
    /// action when tap like button
    ///
    /// - Parameter gesture: a single tap gesture
    /// - Returns: none
    @objc func likeButtonTapped(_:UITapGestureRecognizer){
        
        /// show popup slider bar
        showSliderBarView()
    }
    
    /// present Like level Popup
    ///
    /// - Parameter none
    /// - Returns: none
    func showSliderBarView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "LikeLevelSliderViewController") as? LikeLevelSliderViewController else {
            return
        }
        viewController.initSliderView(likeLevel: viewModel.getLikeLevel(),
                                      name:viewModel.getName(),
                                      delegate: self)
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true, completion: nil)
    }
    
    /// present Detail image view
    ///
    /// - Parameter none
    /// - Returns: none
    func showDetailImage(url:String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailImageViewController") as? DetailImageViewController else {
            return
        }
        viewController.setImageUrl(url: url)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: LikeLevelSliderDelegate
extension ProfileViewController: LikeLevelSliderDelegate {
    
    /// delegate func: notify like level chnaged
    ///
    /// - Parameter level: How much do you like
    /// - Returns: none
    func didChangedLikeLevel(level: Int) {
        /// save data
        viewModel.setLikeLevel(level: level)
        
        /// update UI
        updateLikeButtonAnimation(level: level)
    }
}

// MARK: ProfileDelegate
extension ProfileViewController: ProfileDelegate {
    
    /// reload UI after data updated
    ///
    /// - Parameter none
    /// - Returns: none
    func updateUI() {
        /// reload UI
        loadingView.isHidden = true
        updateHeaderInfo()
        collectionView.reloadData()
    }
    
    /// delegate func: notify fetch data success
    ///
    /// - Parameter none
    /// - Returns: none
    func didFetchProfile() {
        DispatchQueue.main.async {
            /// Update UI here
            self.updateUI()
        }
    }
    
    /// delegate func: notify fetch data failed
    ///
    /// - Parameter error: error description
    /// - Returns: none
    func fetchDataError(error: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: "Have a problem when fetch data", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel) { (action:UIAlertAction) in
                print("You've pressed cancel");
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /// map section with type
        let profileSection = ProfileSection(rawValue: section)
        
        switch profileSection {
        case .HorizontalImages, .Info:
            /// only 1 item of these sections
            return 1
        default :
            /// equal to number of images in a moment
            return viewModel.numberOfImagesAtMoment(index: section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// map section with type
        let profileSection = ProfileSection(rawValue: indexPath.section)
        
        switch profileSection {
            
        case .HorizontalImages:
            /// init cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pageImagesCell, for: indexPath) as! PageImagesCollectionViewCell
            /// configure cell
            cell.initUI(imageUrls: viewModel.horizontalImageUrls(),
                        width: collectionView.frame.width,
                        height: collectionView.frame.width / horizontalCellRatio)
            return cell
            
        case .Info:
            /// init cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoCell, for: indexPath) as! InfoCollectionViewCell
            /// configure cell
            cell.initUI(name: viewModel.getName(),
                        ageInfo: viewModel.getBirthDateSting(),
                        jobInfo: viewModel.getJob(),
                        schoolInfo: viewModel.getSchoolName(),
                        bio: viewModel.getBio())
            return cell
            
        default :
            /// get size of images
            var size:CGSize
            if viewModel.isLargeImageAtIndex(index: indexPath.row, momentIndex: indexPath.section) {
                size = CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
            }else {
                size = CGSize(width: collectionView.frame.width/2, height: collectionView.frame.width/2)
            }
            
            /// handle for first image
            if(indexPath.row == 0) {
                /// init cell
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainMomentPictureCell, for: indexPath) as! MainMomentPictureCollectionViewCell
                /// configure cell
                cell.initUI()
                cell.updateData(location: viewModel.momentLocationAtIndex(index: indexPath.section),
                                status: viewModel.momentStatusAtIndex(index: indexPath.section),
                                momentDescription: viewModel.momentDescriptionAtIndex(index: indexPath.section))
                cell.setImage(urlString: viewModel.imageUrlAtIndex(index: indexPath.row, momentIndex: indexPath.section),
                              size: size)
                
                return cell
            }
            
            /// handle for images left
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: momentPictureCell, for: indexPath) as! MomentPictureCollectionViewCell
            /// configure cell
            cell.setImage(urlString: viewModel.imageUrlAtIndex(index: indexPath.row, momentIndex: indexPath.section),
                          size:size)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// map section with type
        let profileSection = ProfileSection(rawValue: indexPath.section)
        
        switch profileSection {
        case .HorizontalImages:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width / horizontalCellRatio + pageControlHeight)
            
        case .Info:
            /// auto calculate size base on texts
            return estimateCellSize
            
        default:
            if viewModel.isLargeImageAtIndex(index: indexPath.row, momentIndex: indexPath.section) {
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
            }
            /// small image size is a half of large image size
            return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.width/2)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        /// set collection view margin = 0
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profileSection = ProfileSection(rawValue: indexPath.section)
        
        switch profileSection {
        case .HorizontalImages, .Info:
            /// do nothing
            break
        default:
            /// tap on moment image
            showDetailImage(url: viewModel.imageUrlAtIndex(index: indexPath.row, momentIndex: indexPath.section))
            break
        }
    }
}
