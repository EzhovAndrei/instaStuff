//
//  TemplatesStorage+Ext.swift
//  InstaStuff
//
//  Created by aezhov on 12/04/2019.
//  Copyright © 2019 Андрей Ежов. All rights reserved.
//

import UIKit
import CoreData

extension TemplatesStorage {
    
    func fillCoreData() {
        
        let CDSetFetch: NSFetchRequest<CDSet> = CDSet.fetchRequest()
        let CDTemplateFetch: NSFetchRequest<CDTemplate> = CDTemplate.fetchRequest()
        let CDTemplateSettingsFetch: NSFetchRequest<CDTemplateSettings> = CDTemplateSettings.fetchRequest()
        
        let CDAbstractTemplateItemFetch: NSFetchRequest<CDAbstractTemplateItem> = CDAbstractTemplateItem.fetchRequest()
        let CDPhotoFrameInTemplateFetch: NSFetchRequest<CDPhotoFrameInTemplate> = CDPhotoFrameInTemplate.fetchRequest()
        let CDStuffItemInTemplateFetch: NSFetchRequest<CDStuffItemInTemplate> = CDStuffItemInTemplate.fetchRequest()
        let CDViewInTemplateFetch: NSFetchRequest<CDViewInTemplate> = CDViewInTemplate.fetchRequest()
        let CDAbstractItemFetch: NSFetchRequest<CDAbstractItem> = CDAbstractItem.fetchRequest()
        let CDStuffItemFetch: NSFetchRequest<CDStuffItem> = CDStuffItem.fetchRequest()
        let CDTextItemFetch: NSFetchRequest<CDTextItem> = CDTextItem.fetchRequest()
        let CDPhotoFrameItemFetch: NSFetchRequest<CDPhotoFrameItem> = CDPhotoFrameItem.fetchRequest()
        let CDTextSettingsFetch: NSFetchRequest<CDTextSettings> = CDTextSettings.fetchRequest()
        
        [CDSetFetch,
         CDTemplateFetch,
         CDTemplateSettingsFetch,
         CDAbstractTemplateItemFetch,
         CDPhotoFrameInTemplateFetch,
         CDStuffItemInTemplateFetch,
         CDViewInTemplateFetch,
         CDAbstractItemFetch,
         CDStuffItemFetch,
         CDTextItemFetch,
         CDPhotoFrameItemFetch,
         CDTextSettingsFetch
            ].forEach { fetch in
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch as! NSFetchRequest<NSFetchRequestResult>)
                do {
                    try coreDataStack.managedContext.execute(deleteRequest)
                } catch {
                    
                }
        }
        
        let set1 = [set1template1()]
        //, set1template2(), set1template3(), set1template4(), set1template5(), set1template6(), set1template7(), set1template8(), set1template9(), set1template10(), set1template11(), set1template12(), set1template13(), set1template14()]
        
        [(1, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), "Casual", set1), (2, #colorLiteral(red: 0.8901960784, green: 0.862745098, blue: 0.7215686275, alpha: 1), "Lifestyle", []), (3, #colorLiteral(red: 0.8588235294, green: 0.7529411765, blue: 0.6980392157, alpha: 1), "Love", [])].forEach { tupple in
            let set = CDSet(context: coreDataStack.managedContext)
            set.priority = Int64(tupple.0)
            set.buyId = "0"
            set.themeColor = tupple.1
            set.name = tupple.2
            set.templates = NSOrderedSet(array: tupple.3)
        }
        
        fillWithStuff(cdStuffItemFetch: CDStuffItemFetch)
        
        coreDataStack.saveContext()
    }
    
    func fillWithStuff(cdStuffItemFetch: NSFetchRequest<CDStuffItem>) {
        [(1, "stuff_1"), (2, "stuff_2"), (3, "stuff_3"), (4, "stuff_4")].forEach { args in
            let stuff = CDStuffItem(context: coreDataStack.managedContext)
            stuff.id = Int64(args.0)
            stuff.buyId = "0"
            stuff.imageName = args.1
        }
    }
    
    func set1template1() -> CDTemplate {
        let itemInTemplate = stuffInTemplate(itemId: 2, centerX: 50, centerY: 50, angle: .pi / 2, widthScale: 25)
        let textInTemplate = textItemSettings(ratio: 2, centerX: 54, centerY: 120, angle: 0, widthScale: 90)
        textInTemplate.textSettings = defaultTextSettings()
        
        let template = CDTemplate(context: coreDataStack.managedContext)
        template.elements = NSOrderedSet(array: [itemInTemplate, textInTemplate])
        template.name = "set1_template1"
        template.backGroundColor = UIColor.white
        template.backGroundImageName = nil
        template.createdByUser = false
        template.lastChangeDate = Date()
        return template
    }
    //
    //    func set1template2() -> CDTemplate {
    //        let item1InTemplate = emptyFrameItemSettings(ratioX: 96.0, ratioY: 85.0, centerX: 54, centerY: 52)
    //        let item2InTemplate = emptyFrameItemSettings(ratioX: 96.0, ratioY: 85.0, centerX: 54, centerY: 140)
    //
    //        let template = CDTemplate(context: coreDataStack.managedContext)
    //        template.items = NSOrderedSet(array: [item1InTemplate, item2InTemplate])
    //        template.name = "Name 2"
    //        template.id = "template2"
    //        return template
    //    }
    //
    //    func set1template3() -> CDTemplate {
    //        let item1InTemplate = emptyFrameItemSettings(ratioX: 77.0, ratioY: 107.0, centerX: 65, centerY: 58)
    //        let item2InTemplate = emptyView(ratioX: 62.0, ratioY: 94.0, centerX: 35, centerY: 140, color: UIColor.white)
    //        let item3InTemplate = emptyFrameItemSettings(ratioX: 58.0, ratioY: 90.0, centerX: 35, centerY: 140)
    //
    //        let template = CDTemplate(context: coreDataStack.managedContext)
    //        template.items = NSOrderedSet(array: [item1InTemplate, item2InTemplate, item3InTemplate])
    //        template.name = "Name 3"
    //        template.id = "template3"
    //        return template
    //    }
    //
    //    func set1template4() -> CDTemplate {
    //        let item1InTemplate = emptyFrameItemSettings(ratioX: 70.0, ratioY: 98.0, centerX: 54, centerY: 124)
    //        let addSettings1 = CDPhotoItemSettings(context: coreDataStack.managedContext)
    //        addSettings1.closeButtonPosition = 2
    //        item1InTemplate.additionalSettings = addSettings1
    //        let item2InTemplate = emptyFrameItemSettings(ratioX: 48.0, ratioY: 74.0, centerX: 30, centerY: 55)
    //        let item3InTemplate = emptyFrameItemSettings(ratioX: 48.0, ratioY: 74.0, centerX: 78, centerY: 72)
    //
    //        let template = CDTemplate(context: coreDataStack.managedContext)
    //        template.items = NSOrderedSet(array: [item1InTemplate, item2InTemplate, item3InTemplate])
    //        template.name = "Name 4"
    //        template.id = "template4"
    //        return template
    //    }
    //
    //    func set1template5() -> CDTemplate {
    //        let item1InTemplate = emptyFrameItemSettings(ratioX: 44, ratioY: 80, centerX: 30, centerY: 58)
    //        let item2InTemplate = emptyFrameItemSettings(ratioX: 44, ratioY: 80, centerX: 78, centerY: 58)
    //        let item3InTemplate = emptyFrameItemSettings(ratioX: 44, ratioY: 80, centerX: 30, centerY: 142)
    //        let item4InTemplate = emptyFrameItemSettings(ratioX: 44, ratioY: 80, centerX: 78, centerY: 142)
    //
    //        let template = CDTemplate(context: coreDataStack.managedContext)
    //        template.items = NSOrderedSet(array: [item1InTemplate, item2InTemplate, item3InTemplate, item4InTemplate])
    //        template.name = "Name 5"
    //        template.id = "template5"
    //        return template
    //    }
    //
    //    func set1template6() -> CDTemplate {
    //        let item1InTemplate = emptyFrameItemSettings(ratioX: 60, ratioY: 80, centerX: 68, centerY: 50)
    //        let item2InTemplate = emptyFrameItemSettings(ratioX: 60, ratioY: 80, centerX: 40, centerY: 142)
    //
    //        let template = CDTemplate(context: coreDataStack.managedContext)
    //        template.items = NSOrderedSet(array: [item1InTemplate, item2InTemplate])
    //        template.name = "Name 6"
    //        template.id = "template6"
    //        return template
    //    }
    //
    //    func set1template7() -> CDTemplate {
    //        let item1InTemplate = emptyFrameItemSettings(ratioX: 70, ratioY: 134, centerX: 39, centerY: 92)
    //        let item2InTemplate = emptyView(ratioX: 62, ratioY: 72, centerX: 72, centerY: 92, color: .white)
    //        item2InTemplate.settings?.rotation = Float(.pi * 10 / 180.0)
    //        let item3InTemplate = emptyFrameItemSettings(ratioX: 58, ratioY: 68, centerX: 72, centerY: 92)
    //        item3InTemplate.settings?.rotation = Float(.pi * 10 / 180.0)
    //
    //        let template = CDTemplate(context: coreDataStack.managedContext)
    //        template.items = NSOrderedSet(array: [item1InTemplate, item2InTemplate, item3InTemplate])
    //        template.name = "Name 7"
    //        template.id = "template7"
    //        return template
    //    }
    //
    //    func set1template8() -> CDTemplate {
    //        let item1InTemplate = emptyFrameItemSettings(ratioX: 94, ratioY: 60, centerX: 54, centerY: 34)
    //        let item2InTemplate = emptyView(ratioX: 84, ratioY: 124, centerX: 54, centerY: 117, color: .white)
    //        let item3InTemplate = emptyFrameItemSettings(ratioX: 80, ratioY: 120, centerX: 54, centerY: 117)
    //
    //        let template = CDTemplate(context: coreDataStack.managedContext)
    //        template.items = NSOrderedSet(array: [item1InTemplate, item2InTemplate, item3InTemplate])
    //        template.name = "Name 8"
    //        template.id = "template8"
    //        return template
    //    }
    //
    //    func set1template9() -> CDTemplate {
    //        let item1InTemplate = emptyFrameItemSettings(ratioX: 108, ratioY: 192, centerX: 54, centerY: 94)
    //        let addSettings1 = CDPhotoItemSettings(context: coreDataStack.managedContext)
    //        addSettings1.closeButtonPosition = 0
    //        addSettings1.plusLocationX = 0.5
    //        addSettings1.plusLocationY = 12.0/192.0
    //        item1InTemplate.additionalSettings = addSettings1
    //        let item2InTemplate = emptyView(ratioX: 84, ratioY: 144, centerX: 54, centerY: 94)
    //        let item3InTemplate = emptyFrameItemSettings(ratioX: 80, ratioY: 140, centerX: 54, centerY: 94)
    //
    //        let template = CDTemplate(context: coreDataStack.managedContext)
    //        template.items = NSOrderedSet(array: [item1InTemplate, item2InTemplate, item3InTemplate])
    //        template.name = "Name 9"
    //        template.id = "template9"
    //        return template
    //    }
    //
    //    func set1template10() -> CDTemplate {
    //        let item1InTemplate = emptyFrameItemSettings(ratioX: 108, ratioY: 192, centerX: 54, centerY: 96)
    //        let addSettings1 = CDPhotoItemSettings(context: coreDataStack.managedContext)
    //        addSettings1.closeButtonPosition = 0
    //        addSettings1.plusLocationX = 12.0/108.0
    //        addSettings1.plusLocationY = 37.0/192.0
    //        item1InTemplate.additionalSettings = addSettings1
    //
    //        let item2InTemplate = emptyView(ratioX: 84, ratioY: 104, centerX: 63, centerY: 66)
    //        let item3InTemplate = emptyFrameItemSettings(ratioX: 80, ratioY: 100, centerX: 63, centerY: 66)
    //
    //        let item4InTemplate = emptyView(ratioX: 74, ratioY: 84, centerX: 40, centerY: 134)
    //        let item5InTemplate = emptyFrameItemSettings(ratioX: 70, ratioY: 80, centerX: 40, centerY: 134)
    //        let addSettings3 = CDPhotoItemSettings(context: coreDataStack.managedContext)
    //        addSettings3.closeButtonPosition = 1
    //        addSettings3.plusLocationX = 0.5
    //        addSettings3.plusLocationY = 0.5
    //        item3InTemplate.additionalSettings = addSettings3
    //
    //        let item6InTemplate = emptyView(ratioX: 47, ratioY: 47, centerX: 75, centerY: 108)
    //        let item7InTemplate = emptyFrameItemSettings(ratioX: 43, ratioY: 43, centerX: 75, centerY: 108)
    //
    //        let template = CDTemplate(context: coreDataStack.managedContext)
    //        template.items = NSOrderedSet(array: [item1InTemplate, item2InTemplate, item3InTemplate, item4InTemplate, item5InTemplate, item6InTemplate, item7InTemplate])
    //        template.name = "Name 10"
    //        template.id = "template10"
    //        return template
    //    }
    //
    //    func set1template11() -> CDTemplate {
    //        let item1InTemplate = emptyFrameItemSettings(ratioX: 80, ratioY: 128, centerX: 54, centerY: 77)
    //        let item2InTemplate = emptyTextItemSettings(ratioX: 80, ratioY: 34, centerX: 54, centerY: 162)
    //
    //        let template = CDTemplate(context: coreDataStack.managedContext)
    //        template.items = NSOrderedSet(array: [item1InTemplate, item2InTemplate])
    //        template.name = "Name 11"
    //        template.id = "template11"
    //        return template
    //    }
    //
    //    func set1template12() -> CDTemplate {
    //        let item1InTemplate = emptyFrameItemSettings(ratioX: 80, ratioY: 90, centerX: 54, centerY: 96)
    //        let item2InTemplate = emptyTextItemSettings(ratioX: 80, ratioY: 34, centerX: 54, centerY: 162)
    //        let item3InTemplate = emptyTextItemSettings(ratioX: 80, ratioY: 34, centerX: 54, centerY: 30)
    //
    //        let template = CDTemplate(context: coreDataStack.managedContext)
    //        template.items = NSOrderedSet(array: [item1InTemplate, item2InTemplate, item3InTemplate])
    //        template.name = "Name 12"
    //        template.id = "template12"
    //        return template
    //    }
    //
    //    func set1template13() -> CDTemplate {
    //        let item1InTemplate = emptyFrameItemSettings(ratioX: 88, ratioY: 94, centerX: 54, centerY: 96)
    //        let item2InTemplate = emptyView(ratioX: 72, ratioY: 68, centerX: 54, centerY: 148)
    //        let item3InTemplate = emptyFrameItemSettings(ratioX: 68, ratioY: 64, centerX: 54, centerY: 148)
    //        let item4InTemplate = emptyTextItemSettings(ratioX: 88, ratioY: 34, centerX: 54, centerY: 30)
    //
    //        let template = CDTemplate(context: coreDataStack.managedContext)
    //        template.items = NSOrderedSet(array: [item1InTemplate, item2InTemplate, item3InTemplate, item4InTemplate])
    //        template.name = "Name 13"
    //        template.id = "template13"
    //        return template
    //    }
    //
    //    func set1template14() -> CDTemplate {
    //        let item1InTemplate = emptyFrameItemSettings(ratioX: 108, ratioY: 192, centerX: 54, centerY: 96)
    //        let addSettings1 = CDPhotoItemSettings(context: coreDataStack.managedContext)
    //        addSettings1.closeButtonPosition = 0
    //        addSettings1.plusLocationX = 0.5
    //        addSettings1.plusLocationY = 12.0/192.0
    //        item1InTemplate.additionalSettings = addSettings1
    //        let item2InTemplate = emptyView(ratioX: 84, ratioY: 117, centerX: 54, centerY: 84)
    //        let item3InTemplate = emptyFrameItemSettings(ratioX: 80, ratioY: 113, centerX: 54, centerY: 84)
    //        let item4InTemplate = emptyTextItemSettings(ratioX: 80, ratioY: 34, centerX: 54, centerY: 163)
    //
    //        let template = CDTemplate(context: coreDataStack.managedContext)
    //        template.items = NSOrderedSet(array: [item1InTemplate, item2InTemplate, item3InTemplate, item4InTemplate])
    //        template.name = "Name 14"
    //        template.id = "template14"
    //        return template
    //    }
    //
    //    private func emptyFrameItemSettings(ratioX: CGFloat, ratioY: CGFloat, centerX: CGFloat, centerY: CGFloat) -> CDPhotoItemInTemplate {
    //        let itemSettings = CDSettings(context: coreDataStack.managedContext)
    //        itemSettings.centerX = 0.5
    //        itemSettings.centerY = 0.5
    //        itemSettings.width = 1
    //        itemSettings.rotation = 0
    //        itemSettings.ratio = Float(ratioX/ratioY)
    //
    //        let item = CDPhotoItem(context: coreDataStack.managedContext)
    //        item.id = "empty\(Int(ratioX))to\(Int(ratioY))"
    //        item.settings = itemSettings
    //
    //        let itemSettingsInFrame = CDSettings(context: coreDataStack.managedContext)
    //        itemSettingsInFrame.centerX = Float(centerX/108.0)
    //        itemSettingsInFrame.centerY = Float(centerY/192.0)
    //        itemSettingsInFrame.width = Float(ratioX/108.0)
    //        itemSettingsInFrame.rotation = 0
    //        itemSettingsInFrame.ratio = Float(ratioX/ratioY)
    //
    //        let photoItemInTemplate = CDPhotoItemInTemplate(context: coreDataStack.managedContext)
    //        photoItemInTemplate.photoItem = item
    //        photoItemInTemplate.settings = itemSettingsInFrame
    //
    //        return photoItemInTemplate
    //    }
    //
    
    //
    //    private func emptyView(ratioX: CGFloat, ratioY: CGFloat, centerX: CGFloat, centerY: CGFloat, color: UIColor = .white) -> CDViewInTemplate {
    //        let itemSettingsInFrame = CDSettings(context: coreDataStack.managedContext)
    //        itemSettingsInFrame.centerX = Float(centerX/108.0)
    //        itemSettingsInFrame.centerY = Float(centerY/192.0)
    //        itemSettingsInFrame.width = Float(ratioX/108.0)
    //        itemSettingsInFrame.rotation = 0
    //        itemSettingsInFrame.ratio = Float(ratioX/ratioY)
    //
    //        let itemInTemplate = CDViewInTemplate(context: coreDataStack.managedContext)
    //        itemInTemplate.settings = itemSettingsInFrame
    //        itemInTemplate.color = color
    //
    //        return itemInTemplate
    //    }
    
    
    
}

// MARK: - Save Delete

extension TemplatesStorage {
    
    func saveTemplateInCD(_ template: Template) {
        let items: [CDAbstractTemplateItem] = template.storyEditableItem.map { item in
            switch item {
            case let stuff as StoryEditableStuffItem:
                return stuffInTemplate(stuff: stuff)
            case let text as StoryEditableTextItem:
                return textItemInTemplate(text: text)
            default:
                return nil
            }
            }.compactMap { $0 }
        
        deleteTemplateFromDB(template)
        
        let cdTemplate = CDTemplate(context: coreDataStack.managedContext)
        cdTemplate.lastChangeDate = Date()
        cdTemplate.createdByUser = true
        cdTemplate.elements = NSOrderedSet(array: items)
        cdTemplate.name = template.name
        cdTemplate.backGroundColor = template.backgroundColor
        cdTemplate.backGroundImageName = template.backgroundImageName
        
        //print("COUNT: \(try? coreDataStack.managedContext.fetch(CDTextSettings.fetchRequest()).count ?? 0)")
        
        coreDataStack.saveContext()
    }
    
    func deleteTemplateFromDB(_ template: Template) {
        let tempalteFetch: NSFetchRequest<NSFetchRequestResult> = CDTemplate.fetchRequest()
        tempalteFetch.predicate = NSPredicate(format: "name == '\(template.name)'")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: tempalteFetch)
        do {
            try coreDataStack.managedContext.execute(deleteRequest)
        } catch {
            
        }
        coreDataStack.saveContext()
    }
}


// MARK: - Item to Core Data

extension TemplatesStorage {
    
    private func stuffInTemplate(stuff: StoryEditableStuffItem) -> CDStuffItemInTemplate {
        return stuffInTemplate(itemId: stuff.stuffItem.stuffId,
                               centerX: stuff.settings.center.x,
                               centerY: stuff.settings.center.y,
                               angle: stuff.settings.angle,
                               widthScale: stuff.settings.sizeWidth,
                               applyScale: false)
    }
    
    private func textItemInTemplate(text: StoryEditableTextItem) -> CDTextItemInTemplate {
        let textItem = text.textItem
        let textSetups = textItem.textSetups
        let itemInTemplate = textItemSettings(ratio: textItem.ratio,
                                centerX: text.settings.center.x,
                                centerY: text.settings.center.y,
                                angle: text.settings.angle,
                                widthScale: text.settings.sizeWidth,
                                applyScale: false,
                                text: textSetups.currentText.value)
        itemInTemplate.textSettings = textSettings(aligment: textSetups.aligment,
                                                   color: textSetups.color,
                                                   backgroundColor: textSetups.backgroundColor,
                                                   fontSize: textSetups.fontSize,
                                                   kern: textSetups.kern,
                                                   lineSpacing: textSetups.lineSpacing,
                                                   fontName: textSetups.fontType,
                                                   text: textSetups.currentText.value)
        return itemInTemplate
    }
    
    
}

// MARK: - Data to Core Data

extension TemplatesStorage {
    
    private func textItemSettings(ratio: CGFloat, centerX: CGFloat, centerY: CGFloat, angle: CGFloat, widthScale: CGFloat, applyScale: Bool = true, text: String? = nil) -> CDTextItemInTemplate {
        
        let textInTemplate = CDTextItemInTemplate(context: coreDataStack.managedContext)
        
        textInTemplate.ratio = Float(ratio)
        let settings = generateSettings(centerX: centerX, centerY: centerY, angle: angle, widthScale: widthScale, applyScale: applyScale)

        textInTemplate.settings = settings
        
        return textInTemplate
    }
    
    private func generateSettings(centerX: CGFloat, centerY: CGFloat, angle: CGFloat, widthScale: CGFloat, applyScale: Bool = true) -> CDTemplateSettings {
        let settings = CDTemplateSettings(context: coreDataStack.managedContext)
        settings.midX = Float(centerX / (applyScale ? 108.0 : 1))
        settings.midY = Float(centerY / (applyScale ? 192.0 : 1))
        settings.angle = Float(angle)
        settings.widthScale = Float(widthScale / (applyScale ? 108.0 : 1))
        return settings
    }
    
    private func defaultTextSettings() -> CDTextSettings {
        return textSettings(aligment: .center, color: .black, backgroundColor: .clear, fontSize: 40, kern: 1, lineSpacing: 1, fontName: .cheque, text: "Type your text")
    }
    
    private func textSettings(aligment: Aligment, color: UIColor, backgroundColor: UIColor, fontSize: CGFloat, kern: CGFloat, lineSpacing: CGFloat, fontName: FontEnum, text: String) -> CDTextSettings {
        
        let textSettings = CDTextSettings(context: coreDataStack.managedContext)
        textSettings.aligment = Int64(aligment.rawValue)
        textSettings.backgroundColor = backgroundColor
        textSettings.color = color
        textSettings.fontSize = Float(fontSize)
        textSettings.kern = Float(kern)
        textSettings.lineSpacing = Float(lineSpacing)
        textSettings.fontName = fontName.rawValue
        textSettings.text = text
        
        return textSettings
    }
    
    private func stuffInTemplate(itemId: Int, centerX: CGFloat, centerY: CGFloat, angle: CGFloat, widthScale: CGFloat, applyScale: Bool = true) -> CDStuffItemInTemplate {
        let stuffInTemplate = CDStuffItemInTemplate(context: coreDataStack.managedContext)
        stuffInTemplate.itemId = Int64(itemId)
        
        let settings = generateSettings(centerX: centerX, centerY: centerY, angle: angle, widthScale: widthScale, applyScale: applyScale)
        
        stuffInTemplate.settings = settings
        
        return stuffInTemplate
    }
}
