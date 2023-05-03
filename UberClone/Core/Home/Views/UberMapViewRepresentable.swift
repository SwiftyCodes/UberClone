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
        mapView.isRotateEnabled = true
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Update the Views or Mapview in this case here
        //Like draw lines and etc.
        if let selectedLocation = locationSearchViewModel.selectedLocation {
            print("DEBUG : selected location is \(selectedLocation)")
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
        
        let parent : UberMapViewRepresentable
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        //Here we set the location on map
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            //span - is the amount of zoom we want on that cordinate.
            let regionArea = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            
                parent.mapView.setRegion(regionArea, animated: true)
        }
    }
}
