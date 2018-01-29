//
//  SearchView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 08/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import STPopup

class SearchView: BaseView {
    // Mark: - Attributes -
    
    var txtLocation : BaseTextField!
    var txtPeopleSearch : BaseTextField!
    
    var segmentView : SegmentControlView!
    var scrollView : BaseScrollView!
    var contantView : UIView!
    
    var peopleView : PeopleView!
    var placeView : PlaceView!
    
    var searchTimer : Timer!
    
    var arrCourt : [Court]! = [Court]()
    var isDrag = false
    
    var selectedPlace : LocationAddress? = nil {
        didSet {
            if placeView == nil {
                return
            }
            if selectedPlace != nil {
                self.loadHomeCourtRequest(coordinate: CLLocationCoordinate2D(latitude: selectedPlace!.latitude, longitude: selectedPlace!.longitude))
            }
            else {
                self.txtLocation.text = ""
            }
        }
    }
    
    // MARK: - Lifecycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    deinit {
        print("SearchView deinit called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if peopleView != nil && peopleView.superview != nil {
            peopleView.removeFromSuperview()
            peopleView = nil
        }
        if placeView != nil && placeView.superview != nil {
            placeView.removeFromSuperview()
            placeView = nil
        }
        
        if contantView != nil && contantView.superview != nil {
            contantView.removeFromSuperview()
            contantView = nil
        }
        
        if scrollView != nil && scrollView.superview != nil {
            scrollView.removeFromSuperview()
            scrollView = nil
        }
        
        if segmentView != nil && segmentView.superview != nil {
            segmentView.removeFromSuperview()
            segmentView = nil
        }
        
        if txtPeopleSearch != nil && txtPeopleSearch.superview != nil {
            txtPeopleSearch.removeFromSuperview()
            txtPeopleSearch = nil
        }
        
        if txtLocation != nil && txtLocation.superview != nil {
            txtLocation.removeFromSuperview()
            txtLocation = nil
        }
        
        
        selectedPlace = nil
        arrCourt = nil
        searchTimer = nil
    }
    
    
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        txtLocation = BaseTextField(iSuperView: self, TextFieldType: .baseNoClearButtonTextFieldType)
        txtLocation.placeholder = "Search Location"
        txtLocation.setLeftIcon(icon: UIImage(named: "Search"))
        txtLocation.delegate = self
        txtLocation.returnKeyType = .search
        
        txtPeopleSearch = BaseTextField(iSuperView: self, TextFieldType: .baseNoClearButtonTextFieldType)
        txtPeopleSearch.placeholder = "Search People"
        txtPeopleSearch.setLeftIcon(icon: UIImage(named: "Search"))
        txtPeopleSearch.delegate = self
        txtPeopleSearch.isHidden = true
        txtPeopleSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        segmentView = SegmentControlView(titleArray: ["Place", "People"], iSuperView: self)
        
        scrollView = BaseScrollView(scrollType: .horizontal, superView: self)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isScrollEnabled = false
        contantView = scrollView.container
        
        placeView = PlaceView(frame: .zero)
        placeView.locationManager.delegate = self
        placeView.mapView.delegate = self
        contantView.addSubview(placeView)
        
        peopleView = PeopleView(frame: .zero)
        contantView.addSubview(peopleView)
        
        segmentView.setSegmentTabbedEvent { [weak self] (index) in
            if self == nil {
                return
            }
            self?.endEditing(false)
            if index == 0 {
                let scrollPoint = CGPoint(x: 0, y: 0)
                self!.scrollView.setContentOffset(scrollPoint, animated: false)
                self!.txtLocation.isHidden = false
                self!.txtPeopleSearch.isHidden = true
            }
            else if index == 1 {
                let scrollPoint = CGPoint(x: self!.scrollView.frame.size.width, y: 0)
                self!.scrollView.setContentOffset(scrollPoint, animated: false)
                self!.txtLocation.isHidden = true
                self!.txtPeopleSearch.isHidden = false
            }
        }
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["txtLocation" : txtLocation,
                                     "txtPeopleSearch" : txtPeopleSearch,
                                     "segmentView" : segmentView,
                                     "scrollView" : scrollView,
                                     "peopleView" : peopleView,
                                     "placeView" : placeView]
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let virticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVirticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        let turneryHorizontalPadding : CGFloat = ControlLayout.turneryHorizontalPadding
        let turneryVerticalPadding : CGFloat = ControlLayout.turneryVerticalPadding
        
        baseLayout.metrics = ["horizontalPadding" : horizontalPadding,
                              "virticalPadding" : virticalPadding,
                              "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                              "secondaryVirticalPadding" : secondaryVirticalPadding,
                              "turneryHorizontalPadding" : turneryHorizontalPadding,
                              "turneryVerticalPadding" : turneryVerticalPadding]
        
        txtLocation.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        txtLocation.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        segmentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalPadding).isActive = true
        segmentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalPadding).isActive = true
        
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-virticalPadding-[txtLocation]-virticalPadding-[segmentView]-virticalPadding-[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_V)
        
        
        //contant view
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|[placeView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        contantView.addConstraints(baseLayout.control_V)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[placeView][peopleView]|", options: [.alignAllTop, .alignAllBottom], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        contantView.addConstraints(baseLayout.control_H)
        
        placeView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0).isActive = true
        peopleView.widthAnchor.constraint(equalTo: placeView.widthAnchor, multiplier: 1.0).isActive = true
        
        
        txtPeopleSearch.leadingAnchor.constraint(equalTo: txtLocation.leadingAnchor).isActive = true
        txtPeopleSearch.trailingAnchor.constraint(equalTo: txtLocation.trailingAnchor).isActive =  true
        txtPeopleSearch.topAnchor.constraint(equalTo: txtLocation.topAnchor).isActive =  true
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    // MARK: - Internal Helpers -
    
    func displayCourts() {
        
        for (index, court) in arrCourt.enumerated() {
            var marker : GMSMarker! = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(court.latitude)!, longitude: Double(court.longitude)!))
            marker.zIndex = Int32(index)
            //marker.icon = GMSMarker.markerImage(with: UIColor.init(hex: court.color))
            marker.icon = UIImage(named: "MarkerSmall")?.maskWithColor(UIColor.init(hex: court.color))
            marker.snippet = court.homeCourtName
            marker.map = self.placeView.mapView
            marker = nil
        }
    }
    
    
    
    func textFieldDidChange(_ textField: UITextField) {
        
        if txtPeopleSearch.text?.trimmed() != "" {
            if searchTimer != nil {
                searchTimer.invalidate()
                searchTimer = nil
            }
            searchTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(invokeTimeAction(sender:)), userInfo: textField.text, repeats: false)
            
        }
        else {
            if searchTimer != nil {
                searchTimer.invalidate()
                searchTimer = nil
            }
        }
    }
    
    func invokeTimeAction(sender : Timer) {
        
        self.peopleView.peopleArr.removeAll()
        self.peopleView.tblPeopleList.reloadData()
        self.txtPeopleSearch.resignFirstResponder()
        self.SearchPeopleRequest(SearchKey: sender.userInfo as! String)
    }
    
    fileprivate func getPlaceAddress(_ coordinate : CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            
            AppUtility.isNetworkAvailableWithBlock({ [weak self] (available) in
                if self == nil {
                    return
                }
                
                if available {
                    self!.showProgressHUD(viewController: self!.placeView, title: nil, subtitle: nil)
                    geocoder.reverseGeocodeCoordinate(coordinate) { [weak self] response , error in
                        if self == nil {
                            return
                        }
                        self!.placeView.hideProgressHUD()
                        if response != nil {
                            if let address = response?.firstResult() {
                                
                                let place = LocationAddress()
                                
                                let lines = address.lines! as [String]
                                place.locationName = lines.joined(separator: " ")
                                
                                place.latitude = address.coordinate.latitude
                                place.longitude = address.coordinate.longitude
                                
                                self!.selectedPlace = place
                            }
                            else {
                                self!.selectedPlace = nil
                            }
                        }
                        else {
                            self!.placeView.makeToast("Fail to locate location")
                            self!.selectedPlace = nil
                        }
                    }
                }
                else {
                    self!.placeView.makeToast(ErrorMessage.noInternet)
                }
            })
        }
    }
    
    // MARK: - Server Request -
    
    fileprivate func loadHomeCourtRequest(coordinate : CLLocationCoordinate2D) {
        
        if !self.placeView.isLoadedRequest {
            
            self.placeView.mapView.clear()
            self.arrCourt.removeAll()
            
            self.txtLocation.text = selectedPlace!.locationName
            let circ = GMSCircle(position: CLLocationCoordinate2D(latitude: selectedPlace!.latitude, longitude: selectedPlace!.longitude), radius: General.kCircleRadios * 1609.34)
            circ.fillColor = Color.appIntermidiateBG.withAlpha(0.15)
            circ.strokeColor = Color.appSecondaryBG.withAlpha(0.5)
            circ.strokeWidth = 2.5;
            circ.map = self.placeView.mapView
            
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(coordinate.latitude, forKey: "latitude")
            dictParameter.setValue(coordinate.longitude, forKey: "longitude")
            
            self.placeView.isLoadedRequest = true
            
            BaseAPICall.shared.postReques(URL: APIConstant.fetchHomeCourts, Parameter: dictParameter, Type: APITask.FetchHomeCourts, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result {
                case .Success(let object, let error):
                    self!.placeView.isLoadedRequest = false
                    self!.placeView.hideProgressHUD()
                    self!.arrCourt = object as! [Court]
                    self!.displayCourts()
                    self!.placeView.makeToast(error!.alertMessage)
                    break
                    
                case .Error(let error):
                    self!.placeView.isLoadedRequest = false
                    self!.placeView.hideProgressHUD()
                    self!.placeView.makeToast(error!.alertMessage)
                    
                    break
                case .Internet(let isOn):
                    self!.handleNetworkCheck(isAvailable: isOn, insideView: self!.placeView)
                    break
                }
            })
        }
    }
    
    fileprivate func SearchPeopleRequest(SearchKey : String) {
        
        if !self.peopleView.isLoadedRequest {
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(SearchKey, forKey: "searchString")
            
            self.peopleView.isLoadedRequest = true
            
            BaseAPICall.shared.postReques(URL: APIConstant.searchPeople, Parameter: dictParameter, Type: APITask.searchPeople, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(let object, let error):
                    self!.peopleView.isLoadedRequest = false
                    self!.peopleView.hideProgressHUD()
                    self!.peopleView.peopleArr = object as! [People]
                    self!.peopleView.tblPeopleList.reloadData()
                    self!.peopleView.tblPeopleList.scrollsToTop = true
                    self!.peopleView.makeToast(error!.alertMessage)
                    
                    break
                    
                case .Error(let error):
                    self!.peopleView.isLoadedRequest = false
                    self!.peopleView.hideProgressHUD()
                    self!.peopleView.makeToast(error!.alertMessage)
                    break
                    
                case .Internet(let isOn):
                    self!.handleNetworkCheck(isAvailable: isOn, insideView: self!.peopleView)
                    break
                }
            })
        }
    }
    
    fileprivate func setHomeCourtRequest(homeCourtId : String) {
        operationQueue.cancelAllOperations()
        operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(homeCourtId, forKey: "homeCourtId")
            
            BaseAPICall.shared.postReques(URL: APIConstant.addUserHomeCourt, Parameter: dictParameter, Type: APITask.AddUserHomeCourt, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(_, let error):
                    AppUtility.setUserDefaultsObject("1" as AnyObject, forKey: UserDefaultKey.KHomeCourtId)
                    self!.placeView.hideProgressHUD()
                    self!.placeView.makeToast(error!.alertMessage)
                    break
                    
                case .Error(let error):
                    self!.placeView.hideProgressHUD()
                    self!.placeView.makeToast(error!.alertMessage)
                    break
                    
                case .Internet(let isOn):
                    self!.handleNetworkCheck(isAvailable: isOn, insideView: self!.placeView)
                    break
                }
            })
        }
    }
}

extension SearchView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x == 0 {
            self.segmentView.setSegementSelectedAtIndex(0)
        }
        
        if scrollView.contentOffset.x == scrollView.frame.size.width  {
            self.segmentView.setSegementSelectedAtIndex(1)
        }
    }
}

extension SearchView : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtLocation {
            textField.endEditing(true)
            textField.resignFirstResponder()
            var autocompleteController : GMSAutocompleteViewController! = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            
            let filter = GMSAutocompleteFilter()
            filter.type = .noFilter
            autocompleteController.autocompleteFilter = filter
            self.getViewControllerFromSubView()?.present(autocompleteController, animated: true, completion: nil)
            autocompleteController = nil
        }
    }
    
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField == txtLocation {
            self.selectedPlace = nil
        }
        return true
    }
}
// MARK: - GMSAutocompleteViewControllerDelegate
extension SearchView: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.getViewControllerFromSubView()?.dismiss(animated: true, completion: { [weak self] in
            if self == nil {
                return
            }
            self!.isDrag = false
            viewController.delegate = nil
            
            let tempPlace : LocationAddress = LocationAddress()
            tempPlace.latitude = place.coordinate.latitude
            tempPlace.longitude = place.coordinate.longitude
            tempPlace.locationName = place.name
            tempPlace.locationAddress = place.formattedAddress
            
            self!.placeView.mapView.camera = GMSCameraPosition(target: place.coordinate, zoom: 10.8, bearing: 5.5, viewingAngle: 2.2)
            self?.selectedPlace = tempPlace
            self!.txtLocation.resignFirstResponder()
        })
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.getViewControllerFromSubView()?.dismiss(animated: true, completion: { [weak self] in
            if self == nil {
                return
            }
            
            viewController.delegate = nil
            self!.txtLocation.resignFirstResponder()
        })
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}



// MARK: - CLLocationManagerDelegate
extension SearchView : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            
            placeView.mapView.isIndoorEnabled = true
            placeView.mapView.isMyLocationEnabled = true
            placeView.mapView.settings.myLocationButton = true
            placeView.mapView.settings.compassButton = true
            placeView.mapView.settings.indoorPicker = true
            placeView.locationManager.startUpdatingLocation()
        }
        else {
            print("Please Give access to use current Location")
            isDrag = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            isDrag = false
            self.getPlaceAddress(location.coordinate)
            self.placeView.isLoadedRequest = false
            placeView.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 10.0, bearing: 5.5, viewingAngle: 2.2)
            placeView.locationManager.stopUpdatingLocation()
        }
    }
}



// MARK: - GMSMapViewDelegate
extension SearchView : GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        mapView.selectedMarker = nil
        if isDrag {
            self.getPlaceAddress(position.target)
            return
        }
        self.isDrag = true
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let controller : SearchViewController = self.getViewControllerFromSubView() as? SearchViewController {
            
            var courtDetail : CourtDetailController! = CourtDetailController(court: self.arrCourt[Int(marker.zIndex)])
            courtDetail.delegate = self
            
            controller.popUp = STPopupController.init(rootViewController: courtDetail)
            controller.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: #selector(controller.closePoup(_:))))
            controller.popUp.navigationBarHidden = true
            controller.popUp.hidesCloseButton = true
            controller.popUp.present(in: controller)
            
            courtDetail = nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        //self.isDrag = false
        mapView.selectedMarker = marker
        return true
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        return false
    }
    
    
}

// MARK: - CourtDetailViewDelegate
extension SearchView : CourtDetailViewDelegate {
    func setAsHomeCourtdidTapped(_ courtDetail: Court) {
        
        if AppUtility.isUserLogin() {
            self.setHomeCourtRequest(homeCourtId: courtDetail.homeCourtId)
            
        }
        else {
            if let controller : SearchViewController = self.getViewControllerFromSubView() as? SearchViewController {
                self.placeView.forceToLoginPopUp = BaseAlertController(iTitle: "Login Required", iMassage: "You must login to set Home Court", iButtonTitle: "Login", index: -1)
                self.placeView.forceToLoginPopUp.delegate = self.placeView
                
                self.placeView.popUp = STPopupController.init(rootViewController: self.placeView.forceToLoginPopUp)
                self.placeView.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self.placeView, action: #selector(self.placeView.closePoup(_:))))
                self.placeView.popUp.navigationBarHidden = true
                self.placeView.popUp.hidesCloseButton = true
                self.placeView.popUp.present(in: controller)
            }
        }
    }
    
    func SeeTheredidTapped(_ courtDetail: Court) {
        if let controller : SearchViewController = self.getViewControllerFromSubView() as? SearchViewController {
            controller.navigationController?.pushViewController(HomeViewController(isBackButton: true, courtId : courtDetail.homeCourtId), animated: true)
        }
    }
}
