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
    
    var mapSelect: String = String()
    var pin = String()
    var timer: NSTimer? = nil
    
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
    
    var busAnnotation = [Station]()
    
    
    override func viewDidLoad() {
        myMap.delegate = self
        zoomToRegion()
        getLatLon(mapSelect)
        let annotation = getAnnotationStop(stopLatArr, lon: stopLonArr, tit: stopTitleArr)
        print("\(stopTitleArr))")
        myMap.addAnnotations(annotation)
        super.viewDidLoad()
        startTimer()
    }
   
    override func viewDidDisappear(animated: Bool) {
        timer?.invalidate()
    }
    
    var num = 0
    func startTimer()
    {
        //onTick()
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "onTick:", userInfo: nil, repeats: true)
    }
    
    
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
    var img = "bus_mini.png"
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? Station{
            let identifier = "pin"
            let title = annotation.title
            var view:MKPinAnnotationView
            //if pin == "stop"
            //{
            if let dequeview = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView{
                dequeview.annotation = annotation
                view = dequeview
            }else{
                
                view =  MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
              
                
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                if title == ""{
                    view.pinTintColor = UIColor.redColor()
                }else{
                    view.pinTintColor = UIColor.blueColor()
                }
            }
            view.image = UIImage(named: "bus_mini")
            view.backgroundColor = UIColor.clearColor()
            return view
        
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
    
    /*func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let latFromPin = view.annotation!.coordinate.latitude
        let lonFromPin = view.annotation!.coordinate.longitude
        let title = view.annotation!.title
        //print(latFromPin)
        //print(lonFromPin)
        print(title)
        print(view.annotation)
        //print("ANnotation clicked")
    }*/

    
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: 40.743193, longitude: -74.178550)
        
        let region = MKCoordinateRegionMakeWithDistance(location, 2000.0, 2000.0)
        
        myMap.setRegion(region, animated: true)
    }

    
    func getAnnotations(lat: [Double],lon: [Double]) -> [Station]
    {
        var annotaions: Array = [Station]()
        for var index = 0; index < lat.count; ++index
        {
            
            let annot = Station(latitude: lat[index], longitude: lon[index],title: "",type: "")
            annot.title = "\(lat[index])  \(lon[index])"
            annotaions.append(annot)
            
        }
        return annotaions
    }
    //var isStop = false
    func getAnnotationStop(lat: [Double],lon: [Double], tit: [String]) -> [Station]
    {
        //pin = "stop"
        var annotaions: Array = [Station]()
        for var index = 0; index < lat.count; ++index
        {
            //sStop = true
            let annot = Station(latitude: lat[index], longitude: lon[index],title: tit[index],type: "stop")
            //annot.title = tit[index]
            annotaions.append(annot)
            
            
        }
        return annotaions
    }
    
    func getBusAnnotation(lat: [Double],lon: [Double]) -> [Station]
    {
        pin = "bus"
       // isStop = false
        var annotaions: Array = [Station]()
        for var index = 0; index < lat.count; ++index
        {
            
            let annot = Station(latitude: lat[index], longitude: lon[index],title: "", type: "bus")
            annotaions.append(annot)
            
        }
        return annotaions
    }


    

    
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
                stopTitleArr.append(stopTitle)
                stopLonArr.append(stopLon)
                stopLatArr.append(stopLat)
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
            
        }
    }
    
    
    
    
}
