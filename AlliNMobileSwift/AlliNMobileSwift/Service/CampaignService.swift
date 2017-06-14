//
//  CampaignService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 12/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class CampaignService: BaseService {
    func getCampaignHTML(idCampaign: Int, completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        HttpRequest.get(action: RouteConstant.CAMPAIGN, params: ["\(idCampaign)"]) { (responseEntity, httpRequestError) in
            self.sendCallback(responseEntity, httpRequestError, completion: completion);
        }
    }
}
