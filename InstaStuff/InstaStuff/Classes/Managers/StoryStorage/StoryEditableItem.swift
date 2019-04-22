//
//  StoryPhotoItem.swift
//  InstaStuff
//
//  Created by Андрей Ежов on 03.03.2019.
//  Copyright © 2019 Андрей Ежов. All rights reserved.
//

import UIKit
import RxSwift

class StoryEditableItem {
    
    let settings: Settings
    
    var renderedImage: UIImage? {
        return nil
    }
    
    fileprivate init(_ settings: Settings) {
        self.settings = settings
    }
    
}

struct EditableTransform {
    var currentTranslation: CGPoint = .zero
    
    var currentRotation: CGFloat = 0
    
    var currentScale: CGFloat = 1
    
    var transform: CGAffineTransform {
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: currentTranslation.x, y: currentTranslation.y)
        transform = transform.rotated(by: currentRotation)
        transform = transform.scaledBy(x: currentScale, y: currentScale)
        return transform
    }
    
    mutating func identity() {
        currentTranslation = .zero
        currentRotation = 0
        currentScale = 1
    }
}

class StoryEditablePhotoItem: StoryEditableItem {
    
    let photoItem: PhotoItem
    
    let customSettings: PhotoItemCustomSettings?
    
    let image: BehaviorSubject<UIImage?>
    
    var editablePhotoTransform = EditableTransform()
    
    private func renderedPhoto() -> UIImage? {
        let photoWidth = Consts.UIGreed.screenWidth * photoItem.photoAreaLocation.sizeWidth * settings.sizeWidth
        let photoSize = CGSize(width: photoWidth,
                               height: photoWidth / photoItem.photoAreaLocation.ratio)
        UIGraphicsBeginImageContext(photoSize)
        
        UIColor.white.setFill()
        let context = UIGraphicsGetCurrentContext()
        context?.fill(CGRect(origin: .zero, size: photoSize))
        
        if let context = UIGraphicsGetCurrentContext(),
            let photo = ((try? self.image.value()) as UIImage??), let unwrapedPhoto = photo {
            context.translateBy(x: photoSize.width / 2.0 + editablePhotoTransform.currentTranslation.x / Consts.UIGreed.globalScale,
                                y: photoSize.height / 2.0 + editablePhotoTransform.currentTranslation.y / Consts.UIGreed.globalScale)
            context.rotate(by: editablePhotoTransform.currentRotation)
            context.scaleBy(x: editablePhotoTransform.currentScale,
                            y: editablePhotoTransform.currentScale)
            let minRatio = min(unwrapedPhoto.size.width/photoSize.width, unwrapedPhoto.size.height/photoSize.height)
            let size = CGSize(width: unwrapedPhoto.size.width / minRatio, height: unwrapedPhoto.size.height / minRatio)
            unwrapedPhoto.draw(in: CGRect(origin: CGPoint(x: -size.width / 2.0, y: -size.height / 2.0), size: size))
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    override var renderedImage: UIImage? {
        let width = Consts.UIGreed.screenWidth
        let size = CGSize(width: width, height: width / settings.ratio)
        UIGraphicsBeginImageContext(size)
        
        let photoWidth = width * photoItem.photoAreaLocation.sizeWidth
        let photoSize = CGSize(width: photoWidth, height: photoWidth / photoItem.photoAreaLocation.ratio)
        
        if let context = UIGraphicsGetCurrentContext(), let photo = renderedPhoto() {
            context.saveGState()
            context.translateBy(x: width * photoItem.photoAreaLocation.center.x,
                                y: size.height * photoItem.photoAreaLocation.center.y)
            context.concatenate(CGAffineTransform(rotationAngle: photoItem.photoAreaLocation.angle))
            photo.draw(in: CGRect(origin: CGPoint(x: -photoSize.width / 2.0, y: -photoSize.height / 2.0), size: photoSize))
            context.restoreGState()
        }
        
        photoItem.framePlaceImage?.draw(in: CGRect(origin: .zero, size: size))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    init(_ photoItem: PhotoItem, customSettings: PhotoItemCustomSettings?, settings: Settings) {
        image = BehaviorSubject(value: nil)
        self.customSettings = customSettings
        self.photoItem = photoItem
        super.init(settings)
    }
    
    func update(image: UIImage?) {
        editablePhotoTransform.identity()
        self.image.onNext(image)
    }
    
}

class StoryEditableTextItem: StoryEditableItem {
    
    let textSetups: TextSetupsEditable
    
    let text: BehaviorSubject<String>
    
    private let bag = DisposeBag()
    
    override var renderedImage: UIImage? {
        let width = Consts.UIGreed.screenWidth
        let textWidth = width * settings.sizeWidth
        
        var image: UIImage?
        
        if let unwrapedText = try? self.text.value() {
            let attributedString = NSAttributedString(string: unwrapedText, attributes: textSetups.realAttributes)
            let rect = attributedString.boundingRect(with: CGSize(width: textWidth, height: Consts.UIGreed.screenHeight),
                                                     options: .usesLineFragmentOrigin, context: nil)
            UIGraphicsBeginImageContext(rect.size)
            NSString(string: unwrapedText).draw(in: rect, withAttributes: textSetups.realAttributes)
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    
        return image
    }
    
    init(_ textItem: TextItem, settings: Settings) {
        textSetups = TextSetupsEditable(textSetups: textItem.textSetups)
        text = BehaviorSubject(value: textItem.defautText)
        super.init(settings)
        textSetups.isUpperCaseSubject.asObservable().subscribe(onNext: { [weak self] isUpperCase in
            if let text = ((try? self?.text.value()) as String??), let textValue = text {
                self?.text.onNext(isUpperCase ? textValue.uppercased() : textValue.capitalized)
            }
        }).disposed(by: bag)
    }
    
}

class StoryEditableStuffItem: StoryEditableItem {
    
    override var renderedImage: UIImage? {
        return stuffItem.stuffImage
    }
    
    let stuffItem: StuffItem
    
    init(_ stuffItem: StuffItem, settings: Settings) {
        self.stuffItem = stuffItem
        super.init(settings)
    }
}

class StoryEditableViewItem: StoryEditableItem {
    
    override var renderedImage: UIImage? {
        let width = Consts.UIGreed.screenWidth
        let viewWidth = width * settings.sizeWidth
        let viewSize = CGSize(width: viewWidth,
                              height: viewWidth / settings.ratio)
        UIGraphicsBeginImageContext(viewSize)
        viewItem.color.setFill()
        let context = UIGraphicsGetCurrentContext()
        context?.fill(CGRect(origin: .zero, size: viewSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    let viewItem: ViewItem
    
    init(_ viewItem: ViewItem, settings: Settings) {
        self.viewItem = viewItem
        super.init(settings)
    }
}
