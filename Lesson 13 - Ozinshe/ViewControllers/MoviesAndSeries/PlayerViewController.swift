//
//  PlayerViewController.swift
//  Lesson 13 - Ozinshe
//
//  Created by Феликс on 04.03.2026.
//

import UIKit
import SnapKit
import YouTubeiOSPlayerHelper

class PlayerViewController: UIViewController {

    var videoID: String = ""
    var movieId: Int = 0
  
    let networkManager = NetworkManager.shared
    
    lazy var webView = {
        let view = YTPlayerView()
        
        view.backgroundColor = .black
        
        return view
    }()
    
    lazy var closeButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.layer.cornerRadius = button.frame.width / 2
        button.addTarget(self, action: #selector(closePlayer), for: .touchUpInside)
        
        return button
    }()
    
    lazy var activityIndicator = {
        let indicator = UIActivityIndicatorView(style: .large)
        
        indicator.color = .white
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadYoutubeVideo()
        addToHistory()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        
        view.addSubviews(webView, closeButton, activityIndicator)
        
        webView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(webView.snp.width).multipliedBy(9.0 / 16.0)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func loadYoutubeVideo() {
        let vars: [String: Any] = [
            "playsinline": 0,
            "autoplay": 1,
            "modestbranding": 1,
            "rel": 1,
            "fullscreen": 1
        ]
        
        webView.load(withVideoId: videoID, playerVars: vars)
    }
    
    private func addToHistory() {
        networkManager.addToHistoryBy(id: movieId) { error in
            print(self.movieId)
            if let error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    @objc private func closePlayer() {
        dismiss(animated: true)
    }
}

extension PlayerViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        print("Ошибка!")
    }
}
