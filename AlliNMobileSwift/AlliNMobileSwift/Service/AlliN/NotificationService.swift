//
//  NotificationService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 09/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class NotificationService : BaseService {
//    var locationService: LocationService;
//
//    override init() {
//        self.locationService = LocationService();
//    }
    
    func campaign(idCampaign: Int, date: String) {
//        self.locationService.start { (latitude, longitude, locationError) in
//            var array: [(key: String, value: Any)] = [
//                (key: BodyConstant.ID, value: "\(idCampaign)"),
//                (key: BodyConstant.DATE, value: date),
//                (key: BodyConstant.DATE_OPENING, value: Date.currentDate(format: "yyyy-MM-dd HH:mm:ss")),
//                (key: BodyConstant.DEVICE_TOKEN, value: AlliNPush.getInstance().deviceToken)
//            ];
//
//            if (latitude != 0.0 && longitude != 0.0 && locationError == nil) {
//                array.append((key: BodyConstant.LATITUDE, value: "\(latitude)"));
//                array.append((key: BodyConstant.LATITUDE, value: "\(longitude)"));
//            }
//
//            guard let data = Data.transform(array: array) else {
//                return;
//            }
//
//            HttpRequest.post(RouteConstant.NOTIFICATION_CAMPAIGN, data: data);
//        }
        let array: [(key: String, value: Any)] = [
            (key: BodyConstant.ID, value: "\(idCampaign)"),
            (key: BodyConstant.DATE, value: date),
            (key: BodyConstant.DATE_OPENING, value: Date.currentDate(format: "yyyy-MM-dd HH:mm:ss")),
            (key: BodyConstant.DEVICE_TOKEN, value: AlliNPush.getInstance().deviceToken)
        ];
        
        guard let data = Data.transform(array: array) else {
            return;
        }
        
        HttpRequest.post(RouteConstant.NOTIFICATION_CAMPAIGN, data: data);
    }
    
    func transactional(idSend: Int, date: String) {
        guard let data = Data.transform(array: [
            (key: BodyConstant.ID, value: "\(idSend)"),
            (key: BodyConstant.DATE, value: date),
            (key: BodyConstant.DATE_OPENING, value: Date.currentDate(format: "yyyy-MM-dd HH:mm:ss"))
            ]) else {
                return;
        }
        
        HttpRequest.post(RouteConstant.NOTIFICATION_TRANSACTIONAL, data: data);
    }
}
