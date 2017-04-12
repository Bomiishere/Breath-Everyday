//
//  ContentManager.swift
//  BreathEveryday
//
//  Created by Lucy on 2017/4/11.
//  Copyright © 2017年 Bomi. All rights reserved.
//
//
//  ArticleManager.swift
//  DemoCoreData
//
//  Created by Lucy on 2017/4/10.
//  Copyright © 2017年 Bomi. All rights reserved.
//

import CoreData
import UIKit

class EventManager {
    
    static let shared = EventManager()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var request = NSFetchRequest<NSFetchRequestResult>(entityName: "EventMO")
    
    let sortDescriptor = NSSortDescriptor(key: "createdDate", ascending: true)
    
    //C
    func create(calendarEvent: String?, content: String?, detail: String?) {
        
        let moc = appDelegate.persistentContainer.viewContext
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "EventMO", in: moc) else {
            
            return
            
        }
        
        let event = EventMO(entity: entityDescription, insertInto: moc)
        
        if let calendarEvent = calendarEvent {
            event.calendarEventID = calendarEvent
        }
        
        if let content = content {
            event.content = content
        }
        
        if let detail = detail {
            event.detail = detail
        }
        
        event.createdDate = NSDate()
        
    }
    
    //R
    func read(id: NSManagedObjectID) -> EventMO? {
        
        let moc = appDelegate.persistentContainer.viewContext
        
        do {
            
            let event = try moc.existingObject(with: id)
            
            guard let eventMO = event as? EventMO else {
                return nil
            }
            
            return eventMO
            
        } catch {
            
            fatalError("\(error)")
        }
        
    }
    
    func readAll() -> [EventMO]? {
        
        let moc = appDelegate.persistentContainer.viewContext
        
        do {
            
            guard let results = try moc.fetch(request) as? [EventMO] else {
                return nil
            }
            
            return results
            
        } catch {
            
            fatalError("\(error)")
        }
        
    }
    
    //U
    func update(id: NSManagedObjectID, content: String?, detail: String?, calendarEvent: String?, alarmDate: NSDate?, isSetNotification: Bool?) {
        
        let moc = appDelegate.persistentContainer.viewContext
        
        do {
            
            let event = try moc.existingObject(with: id)
            
            guard let eventMO = event as? EventMO else {
                return
            }
            
            if let calendarEvent = calendarEvent {
                eventMO.calendarEventID = calendarEvent
            }
            
            if let content = content {
                eventMO.content = content
            }
            
            if let detail = detail {
                eventMO.detail = detail
            }
            
            if let alarmDate = alarmDate {
                eventMO.alarmStartTime = alarmDate
            }
            
            if let isSetNotification = isSetNotification {
                eventMO.isSetNotification = isSetNotification
            }
            
        } catch {
            
            fatalError("\(error)")
        }
        
    }
    
    func update(row: Int, content: String?, detail: String?, calendarEvent: String?, alarmDate: NSDate?, isSetNotification: Bool?) {
        
        let moc = appDelegate.persistentContainer.viewContext
        
        request.sortDescriptors = [sortDescriptor]
        
        do {
            
            guard let results = try moc.fetch(request) as? [EventMO] else {
                return
            }
            
            let event = results[row]
            
            if let calendarEvent = calendarEvent {
                event.calendarEventID = calendarEvent
            }
            
            if let content = content {
                event.content = content
            }
            
            if let detail = detail {
                event.detail = detail
            }
            
            if let alarmDate = alarmDate {
                event.alarmStartTime = alarmDate
            }
            
            if let isSetNotification = isSetNotification {
                event.isSetNotification = isSetNotification
            }
            
        } catch {
            
            fatalError("\(error)")
        }
        
    }
    
    //D
    func delete(id: NSManagedObjectID) {
        
        let moc = appDelegate.persistentContainer.viewContext
        
        do {
            
            let event = try moc.existingObject(with: id)
            
            moc.delete(event)
            
        } catch {
            
            fatalError("\(error)")
        }
        
    }
    
    func deleteAll() {
        
        let moc = appDelegate.persistentContainer.viewContext
        
        do {
            
            guard let results = try moc.fetch(request) as? [EventMO] else {
                return
            }
            
            for result in results {
                
                moc.delete(result)
                
            }
            
            appDelegate.saveContext()
            
        } catch {
            
            fatalError("\(error)")
        }
        
    }
    
}













