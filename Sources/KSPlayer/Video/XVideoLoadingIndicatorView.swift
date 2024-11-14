//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2024 Jellyfin & Jellyfin Contributors
//

import UIKit

class XVideoLoadingIndicatorView: UIView, LoadingIndector {

    private let playIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "play.fill") // Use the play icon from SF Symbols
        imageView.tintColor = .white // Adjust color as needed
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let rotatingCircle: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.blue.cgColor // Customize color
        layer.lineWidth = 3.0
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        return layer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Configure the play icon
        addSubview(playIcon)
        NSLayoutConstraint.activate([
            playIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            playIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            playIcon.widthAnchor.constraint(equalToConstant: 20),
            playIcon.heightAnchor.constraint(equalToConstant: 20),
        ])

        // Configure the rotating circle
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            radius: min(bounds.width, bounds.height) / 2 - 5,
            startAngle: 0,
            endAngle: CGFloat.pi * 2,
            clockwise: true
        )

        rotatingCircle.path = circlePath.cgPath
        layer.addSublayer(rotatingCircle)
    }

    func startAnimating() {
        // Add rotation animation
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2)
        rotationAnimation.duration = 1.0
        rotationAnimation.repeatCount = .infinity
        rotatingCircle.add(rotationAnimation, forKey: "rotationAnimation")
    }

    func stopAnimating() {
        rotatingCircle.removeAnimation(forKey: "rotationAnimation")
    }
}
