//
//  Common.swift
//  InstaStuff
//
//  Created by Андрей Ежов on 10.03.2019.
//  Copyright © 2019 Андрей Ежов. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct Settings {
    var center: CGPoint
    var sizeWidth: CGFloat
    var angle: CGFloat
}

struct PhotoInFrameSettings {
    var center: CGPoint
    let sizeWidth: CGFloat
    let angle: CGFloat
    let ratio: CGFloat
    let round: CGFloat
}

struct FrameAreaDescription {
    enum FrameAreaType {
        case textFrame(TextItem), photoFrame(PhotoItem, PhotoItemCustomSettings?), stuffFrame(StuffItem), viewFrame(ViewItem)
    }
    let settings: Settings
    let frameArea: FrameAreaType
}

struct PhotoItem: PreviewProtocol {
    
    typealias Id = Int
    
    let frameId: PhotoItem.Id
    let frameImageName: String?
    let ratio: CGFloat
    var photoInFrameSettings: PhotoInFrameSettings
    var photoPositionSettings: Settings
    
    var framePlaceImage: UIImage? {
        return UIImage(named: (frameImageName ?? "") + "_frameplace")
    }
    var preview: UIImage? {
        return UIImage(named: (frameImageName ?? "") + "_preview")
    }
}

struct PhotoItemCustomSettings {
    enum CloseButtonPosition: Int16 {
        case rightTop = 0, leftTop = 1, leftBottom = 2, rightBottom = 3
    }
    let closeButtonPosition: CloseButtonPosition?
    let plusLocation: CGPoint?
}

struct TextItem {
    
    static var defaultTextItem: TextItem {
        return TextItem(textSetups: TextSetups.defaultSetups, ratio: 2.0)
    }
    
    var textSetups: TextSetups
    var ratio: CGFloat
    
    func copy() -> TextItem {
        return TextItem(textSetups: textSetups.copy(), ratio: ratio)
    }
}

struct StuffItem: PreviewProtocol {
    
    typealias Id = Int
    
    let stuffId: StuffItem.Id
    
    let imageName: String
    
    var stuffImage: UIImage? {
        return UIImage(named: imageName)
    }
    
    var preview: UIImage? {
        return stuffImage
    }
}

struct ViewItem {
    let color: UIColor
}
