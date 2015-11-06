//
//  ShuttleMapViewController.swift
//  NJIT Student Guide
//
//  Created by Mac on 11/4/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//40.743193, -74.178550

import UIKit
import MapKit

class ShuttleMapViewController: UIViewController, MKMapViewDelegate, NSXMLParserDelegate {

    @IBOutlet weak var myMap: MKMapView!
    var buslat = [Double]()
    var buslon = [Double]()
    
    var timer: NSTimer? = nil
        override func viewDidLoad() {
        myMap.delegate = self
        zoomToRegion()
        getLatLon("Kearney/Harrison")
        let annotation = getAnnotationStop(stopLatArr, lon: stopLonArr, tit: stopTitleArr)
        myMap.addAnnotations(annotation)
        super.viewDidLoad()
        startTimer()
    }
   
    var num = 0
    func startTimer()
    {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "onTick:", userInfo: nil, repeats: false)
    }
    var busAnnotation = [Station]()
    func onTick(timer:NSTimer){
        buslat.removeAll()
        buslon.removeAll()
        myMap.removeAnnotations(busAnnotation)
        let url:NSURL = NSURL(string: "http://webservices.nextbus.com/service/publicXMLFeed?a=rutgers&command=vehicleLocations&t=0000")!
        parse2 = NSXMLParser(contentsOfURL: url)!
        parse2.delegate = self
        parse2.parse()
        print("onTick Called \(num++)")
        busAnnotation = getBusAnnotation(buslat, lon: buslon)
        myMap.addAnnotations(busAnnotation)
        self.startTimer()
          
    }
    
    func drawMap(annotations: [Station])
    {
        var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        
        for annotation in annotations {
            points.append(annotation.coordinate)
        }
        
        let polyline = MKPolyline(coordinates:&points, count: points.count)
        print(points.count)
        myMap.addOverlay(polyline)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if isStop{
            let annotationView = MKPinAnnotationView()
        annotationView.pinTintColor = UIColor.redColor()
            return annotationView
        }else if !isStop{
            let annotationView = MKPinAnnotationView()
            annotationView.pinTintColor = UIColor.greenColor()
            return annotationView
        }
        return nil
    }
    
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 3
            return polylineRenderer
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let latFromPin = view.annotation!.coordinate.latitude
        let lonFromPin = view.annotation!.coordinate.longitude
        let title = view.annotation!.title
        print(latFromPin)
        print(lonFromPin)
        print(title)
        
        print("ANnotation clicked")
    }

    
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: 40.743193, longitude: -74.178550)
        
        let region = MKCoordinateRegionMakeWithDistance(location, 1000.0, 1000.0)
        
        myMap.setRegion(region, animated: true)
    }

    
    func getAnnotations(lat: [Double],lon: [Double]) -> [Station]
    {
        var annotaions: Array = [Station]()
        for var index = 0; index < lat.count; ++index
        {
            
            let annot = Station(latitude: lat[index], longitude: lon[index])
            annot.title = "\(lat[index])  \(lon[index])"
            annotaions.append(annot)
            
        }
        return annotaions
    }
    var isStop = false
    func getAnnotationStop(lat: [Double],lon: [Double], tit: [String]) -> [Station]
    {
        var annotaions: Array = [Station]()
        for var index = 0; index < lat.count; ++index
        {
            isStop = true
            let annot = Station(latitude: lat[index], longitude: lon[index])
            annot.title = tit[index]
            annotaions.append(annot)
            
        }
        return annotaions
    }
    
    func getBusAnnotation(lat: [Double],lon: [Double]) -> [Station]
    {
        isStop = false
        var annotaions: Array = [Station]()
        for var index = 0; index < lat.count; ++index
        {
            
            let annot = Station(latitude: lat[index], longitude: lon[index])
            annotaions.append(annot)
            
        }
        return annotaions
    }


    
    
    var parser:NSXMLParser = NSXMLParser()
    var parse2:NSXMLParser = NSXMLParser()
    var ename : String = String()
    var routeTitle = String()
    var routeTag = String()
    var stopTitle = String()
    var stopLat = Double()
    var stopLon = Double()
    
    var stopTitleArr = [String]()
    var stopLatArr = [Double]()
    var stopLonArr = [Double]()
    
    var pointLat = Double()
    var pointLon = Double()
    var pathBool = false
    var dirBool = false
    var retLon = [Double]()
    var retLat = [Double]()
    
    var map = String()
    func getLatLon(map: String){
        self.map = map
        let url:NSURL = NSURL(string: "http://webservices.nextbus.com/service/publicXMLFeed?a=rutgers&command=routeConfig")!
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.parse()
    }
    

    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        ename = elementName
        if elementName == "route"
        {
            routeTitle = attributeDict["title"]! as String
            if routeTitle == map{
                routeTag = attributeDict["tag"]! as String
            }
        }
        if elementName == "stop"
        {
            if map == routeTitle && !dirBool
            {
                stopTitle = attributeDict["title"]! as String
                stopLat = (attributeDict["lat"]! as NSString).doubleValue
                stopLon = (attributeDict["lon"]! as NSString).doubleValue
            }
        }
        if elementName == "direction"
        {
            dirBool = true
        }
        if elementName == "path"
        {
            dirBool = false
            if pathBool
            {
                let annotations = getAnnotations(retLat, lon: retLon)
                drawMap(annotations)
                retLat.removeAll()
                retLon.removeAll()
            }
            pathBool = true
        }
        if elementName == "point"
        {
            pointLat = (attributeDict["lat"]! as NSString).doubleValue
            pointLon = (attributeDict["lon"]! as NSString).doubleValue
        }
        if elementName == "vehicle"
        {
            let tag = attributeDict["routeTag"]! as String
            if routeTag == tag
            {
            let lat = (attributeDict["lat"]! as NSString).doubleValue
            let lon = (attributeDict["lon"]! as NSString).doubleValue
            buslat.append(lat)
            buslon.append(lon)
            }
            
        }
    }
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
    }
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "point" && routeTitle == map
        {
            retLat.append(pointLat)
            retLon.append(pointLon)
        }
        if elementName == "stop" && !dirBool
        {
            stopTitleArr.append(stopTitle)
            stopLonArr.append(stopLon)
            stopLatArr.append(stopLat)
        }
    }
    
    
    
    
}
