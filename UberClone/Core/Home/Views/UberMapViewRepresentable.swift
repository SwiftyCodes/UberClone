//
//  UberMapView.swift
//  UberClone
//
//  Created by Anudhi on 02/05/23.
//

import SwiftUI
import MapKit

/*This Class is for making a UIview using UIKIT and use to in the SwiftUI
 It acts as a representable here
 
 Summary : UIViewRepresentable
 A wrapper for a UIKit view that you use to integrate that view into your SwiftUI view hierarchy.
 */

struct UberMapViewRepresentable : UIViewRepresentable {
    
    @EnvironmentObject var locationSearchViewModel : LocationSearchViewModel
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    func makeUIView(context: Context) -> some UIView {
        // Do the initial Set up here
        //context.coordinator --> is the MapCoodinator here or the middleman // the Mapview Delegate things / Functionality Level things
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Update the Views or Mapview in this case here
        //Like draw lines and etc.
        
        if let coordinateOfLocationSelected = locationSearchViewModel.selectedLocationCordinate {
            //print("DEBUG : Location cordinates \(selectedLocation)")
            context.coordinator.addAndSelectCoordinates(withCoordinates: coordinateOfLocationSelected)
            context.coordinator.configurePolyLine(withDestinationCoordinate: coordinateOfLocationSelected)
        }
    }
    
    //This represents middleman which will be coordinated with.
    func makeCoordinator() -> MapCordinator {
        return MapCordinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    
    /*
     The UberMapViewRepresentable Struct does not know about this MapCordinator.
     This Class is basically a Middle Man b/w the SwiftUI View and UIkit on funcationality level.
     So here we are using the functionalities from UIkit and then using them in the SwiftUIz
     We want to do things to our MapView and we are doing it from here.
     the parnet constant helps us to comunicate or send data to UberMapViewRepresentable(parent) from child MapCoordinator here.
     */
    
    class MapCordinator : NSObject, MKMapViewDelegate {
        
        //MARK: - Properties
        
        let parent : UberMapViewRepresentable
        var userLocationCoordinate : CLLocationCoordinate2D?
        
        //MARK: - Life Cyclyes
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        //MARK: - Map View Delegates
        
        //Here we set the location on map
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            //span - is the amount of zoom we want on that cordinate.
            let regionArea = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            parent.mapView.setRegion(regionArea, animated: true)
        }
        
        //Display the PolyLine on Map because of this.
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyLine = MKPolylineRenderer(overlay: overlay)
            polyLine.strokeColor = .blue
            polyLine.lineWidth = 4
            return polyLine
        }
        
        //MARK: - Helpers
        
        func addAndSelectCoordinates(withCoordinates coordinates : CLLocationCoordinate2D) {
            //remove all added anotations
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            //add anotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            self.parent.mapView.addAnnotation(annotation)
            self.parent.mapView.selectAnnotation(annotation, animated: true)
            self.parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        func configurePolyLine(withDestinationCoordinate destinationCoordinate : CLLocationCoordinate2D) {
            
            guard let userCoordinate = self.userLocationCoordinate  else {return}
            
            getDestinationRoute(from: userCoordinate, to: destinationCoordinate) { route in
                //Creates a Poly Line here
                self.parent.mapView.addOverlay(route.polyline)
            }
        }
        
        func getDestinationRoute(from userLocation : CLLocationCoordinate2D , to destination : CLLocationCoordinate2D, completion: @escaping (MKRoute) -> Void) {
            
            let userPlaceMark = MKPlacemark(coordinate: userLocation)
            let destinationPlaceMark = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlaceMark)
            request.destination = MKMapItem(placemark: destinationPlaceMark)
            
            let direction = MKDirections(request: request)
            direction.calculate { response, error in
                
                if let err = error {
                    print("DEBUG : Fail with error \(err.localizedDescription)")
                }
                
                guard let route = response?.routes.first else {return}
                completion(route)
            }
        }
    }
}
