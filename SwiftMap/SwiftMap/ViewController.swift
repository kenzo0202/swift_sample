//
//  ViewController.swift
//  SwiftMap
//
//  Created by 岡野健三 on 2017/01/12.
//  Copyright © 2017年 岡野健三. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var mylocationManager:CLLocationManager?
    
    var latitude:Double = Double()
    var longtitude:Double = Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imAt()
    }
    
    func imAt(){
        mylocationManager = CLLocationManager()
        
        mylocationManager?.delegate = self
        map.delegate = self
        
        let status = CLLocationManager.authorizationStatus()
        
        if(status == CLAuthorizationStatus.notDetermined){
            //まだ承認が得られない場合は、承認を得るためにアラートを出す
            
            self.mylocationManager?.requestAlwaysAuthorization()
            self.mylocationManager?.requestWhenInUseAuthorization()
            
        }
        
        //精度がどれくらいなのか決める
        mylocationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        
        //中央に表示する位置
        latitude = (mylocationManager?.location!.coordinate.latitude)!
        longtitude = (mylocationManager?.location!.coordinate.longitude)!
        
        let center = CLLocationCoordinate2D(latitude:latitude,longitude:longtitude)
        
        let span = MKCoordinateSpan(latitudeDelta:0.02,longitudeDelta:0.02)
        
        let theRegion = MKCoordinateRegion(center: center, span: span)
        
        map.setRegion(theRegion, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = center
        
        annotation.title = "ここですよ"
        annotation.subtitle = "ほんとですよ"
        
        map.addAnnotation(annotation)
        
        
        
        
    }
    
    //マップに設置するピンの設定
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //ピンがなかったら終了する
        if annotation is MKUserLocation{
            return nil
        }
        
        //as? => キャストできなければnilが入る
        //as! => キャストできなければエラーにする場合
        //基本的には!のマークはnilの可能性があるけど、nilの場合使いたくないときに使う
        //?マークは、nilの可能性がある場合エラーを出さずに処理できるために使う(けど安易に使うとnilに対してメソッドを用いる場合が起きる可能性がある)
        
        let reuseId = "pin"
        var pinView = map.dequeueReusableAnnotationView(withIdentifier: reuseId) as?
        MKPinAnnotationView
        
        if pinView == nil{
            
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            pinView?.canShowCallout = true
            pinView?.isDraggable = true
            pinView?.tintColor = .purple
            
            let rightButton:AnyObject! = UIButton(type: UIButtonType.detailDisclosure)
            
            pinView?.rightCalloutAccessoryView = rightButton as! UIView
            
        }else{
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    //ピンについているボタンを押したときのメソッド
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        //マップアプリに渡す位置情報を作る
        let cordinate = CLLocationCoordinate2D(latitude: 35.68653331, longitude: 139.6919265)
        
        let placeMark = MKPlacemark(coordinate: cordinate, addressDictionary: nil)
        
        let mapItem = MKMapItem(placemark: placeMark)
        
        //起動オプション
        let option:[String:AnyObject] = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving as AnyObject,
                                         MKLaunchOptionsMapTypeKey: MKMapType.hybrid.rawValue as AnyObject]
        
        mapItem.openInMaps(launchOptions: option)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

