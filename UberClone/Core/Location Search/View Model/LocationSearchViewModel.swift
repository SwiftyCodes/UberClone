//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Anudhi on 03/05/23.
//

import Foundation
import MapKit

class LocationSearchViewModel : NSObject , ObservableObject {
    
    // MARK: - Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocationCordinate : CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment : String = ""{
        didSet{
            //print("DEBUG : Query fragment is \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    func selectedLocation(_ localSearch : MKLocalSearchCompletion) {
        //Here we will use the title and sub title to make the cordinates -- Geo Reverse to Cordinates
        locationSearch(forLoaclSearchCompletion: localSearch) { response, error in
            if let err = error {
                print("DEBUG : Location search fail with error \(err.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else {return}
            let cordinate = item.placemark.coordinate
            self.selectedLocationCordinate = cordinate
        }
    }
    
    func locationSearch(forLoaclSearchCompletion localSearch : MKLocalSearchCompletion, completion : @escaping(MKLocalSearch.CompletionHandler)) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
}

// MARK: - MKLocalSearchCompleterDelegate
extension LocationSearchViewModel : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
