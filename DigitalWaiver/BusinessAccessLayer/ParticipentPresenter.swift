//
//  ParticipentPresenter.swift
//  DigitalWaiver
//
//  Created by Abhishek Singla on 06/11/17.
//  Copyright © 2017 Abhishek. All rights reserved.

//

import Foundation
import CoreData
import SystemConfiguration

protocol ParticipentView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func finishLoadingWithSuccess()
    func finishLoadingOnSuccess(withDict:NSDictionary)
    func showError(withStatus: String)
    func dismissWithDelay(withDelay: Double)

}


class ParticipentPresenter: NSObject {
    let managedObjectContext = AppSharedInstance.sharedInstance.managedObjectContext

    weak fileprivate var participentView : ParticipentView?
    
    override init() {
    
    }
    
    func attachView(_ view:ParticipentView){
        participentView = view
    }
    
    func detachView() {
        participentView = nil
    }
    
    
    func getModelData() {
        
        
    }
    
    func getInitialData() {
        
    }
    
    
    func addNewParticipant(participantInfo:[String : Any]) {
        self.participentView?.startLoading()
        ModelManager.sharedInstance.waverManager.addNewParticipant(participantInfo: participantInfo) { (isSuccess, strMessage) in
            self.participentView?.finishLoading()
            if (isSuccess == true) {
                self.participentView?.finishLoadingOnSuccess(withDict: participantInfo as NSDictionary)
            }
        }
        
    }
    
    
    func getRefreshDataWith(completion: @escaping (NSMutableArray) -> Void) {
        
    }
    
    func getRefreshData() {
        
    }
}
