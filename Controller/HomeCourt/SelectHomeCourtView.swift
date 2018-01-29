//
//  SelectHomeCourtView.swift
//  BallerApp
//
//  Created by WebMobTech-3 on 22/05/17.
//  Copyright © 2017 WebMobTech-3. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import ActiveLabel
import STPopup

class SelectHomeCourtView: BaseView {

    // Mark: - Attributes -
    var txtLocation : BaseTextField!
    var mapView : GMSMapView!
    var lblOr : BaseLabel!
    var btnAddCourt : BaseButton!
    
    var lblSkip : ActiveLabel!
    
    var locationManager : CLLocationManager!
    
    var arrCourt : [Court]! = [Court]()
    
    var isBackButton = false
    
    var forceToLoginPopUp : BaseAlertController!
    var popUp : STPopupController!
    var imgMarker : BaseImageView!
    var isDrag = false
    var selectedPlace : LocationAddress? = nil {
        didSet {
            if self.mapView == nil {
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
    init(isBackButton: Bool) {
        super.init(frame: .zero)
        self.isBackButton = isBackButton
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("SelectHomeCourtView deinit called")
        self.releaseObject()
    }
    
    override func releaseObject() {
        super.releaseObject()
        
        if lblSkip != nil && lblSkip.superview != nil {
            lblSkip.removeFromSuperview()
            lblSkip = nil
        }
        
        if btnAddCourt != nil && btnAddCourt.superview != nil {
            btnAddCourt.removeFromSuperview()
            btnAddCourt = nil
        }
        
        if lblOr != nil && lblOr.superview != nil {
            lblOr.removeFromSuperview()
            lblOr = nil
        }
        
        if mapView != nil && mapView.superview != nil {
            mapView.removeFromSuperview()
            mapView = nil
        }
        
        if txtLocation != nil && txtLocation.superview != nil {
            txtLocation.removeFromSuperview()
            txtLocation = nil
        }
        
        if imgMarker != nil && imgMarker.superview != nil {
            imgMarker.removeFromSuperview()
            imgMarker = nil
        }
        
        locationManager = nil
        arrCourt = nil
        selectedPlace = nil
        forceToLoginPopUp = nil
        popUp = nil
    }
    
    
    // MARK: - Layout -
    
    override func loadViewControls() {
        super.loadViewControls()
        
        txtLocation = BaseTextField(iSuperView: self, TextFieldType: .baseNoClearButtonTextFieldType)
        txtLocation.placeholder = "Search Location"
        txtLocation.setLeftIcon(icon: UIImage(named: "Search"))
        txtLocation.delegate = self
        txtLocation.returnKeyType = .search
        
        mapView = GMSMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mapView)
        
        lblOr = BaseLabel(labelType: .headerSmall, superView: self)
        lblOr.text = "OR"
        
        btnAddCourt = BaseButton(ibuttonType: .primary, iSuperView: self)
        btnAddCourt.setTitle("Add New Home Court", for: .normal)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        
        imgMarker = BaseImageView(type: .defaultImg, superView: self)
        imgMarker.image = UIImage(named: "MarkerNormal")?.withRenderingMode(.alwaysTemplate)
        imgMarker.tintColor = Color.appSecondaryBG.value        
        imgMarker.isHidden = true
        
        lblSkip = ActiveLabel(frame: .zero)
        lblSkip.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lblSkip)
        lblSkip.customize { [weak self] label in
            if self == nil {
                return
            }
            
            label.textColor = Color.lablePrimary.value
            label.text = " Skip "
            let customType = ActiveType.custom(pattern: "\\sSkip\\b")
            label.enabledTypes = [customType]
            label.textAlignment = .center
            label.customColor[customType] = Color.lablePrimary.value
            label.customSelectedColor[customType] = Color.lableSecondry.value
            label.font = UIFont(name: FontStyle.bold, size: 14.0)
            
            label.handleCustomTap(for: customType, handler: { [weak self] (str) in
                if self == nil {
                    return
                }
                
                AppUtility.getAppDelegate().displayDashboardViewOnWindow()
            })
        }
        
        btnAddCourt.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            
            if let controller : SelectHomeCourtController = self?.getViewControllerFromSubView() as? SelectHomeCourtController {
                AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
                    if self == nil {
                        return
                    }
                    
                    if AppUtility.isUserLogin() {
                        if self!.isBackButton == false {
                            controller.navigationController?.pushViewController(AddHomeCourtController(navigationPopType: NavigationPopType.popOnDashBoard), animated: true)
                        }
                        else {
                            controller.navigationController?.pushViewController(AddHomeCourtController(navigationPopType: .popToRoot), animated: true)
                        }
                    }
                    else {
                        
                        self!.forceToLoginPopUp = BaseAlertController(iTitle: "Login Required", iMassage: "You must login to add New Home Court", iButtonTitle: "Login", index: -1)
                        self!.forceToLoginPopUp.delegate = self
                        
                        self!.popUp = STPopupController.init(rootViewController: self!.forceToLoginPopUp)
                        self!.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self!, action: #selector(self!.closePoup(_:))))
                        self!.popUp.navigationBarHidden = true
                        self!.popUp.hidesCloseButton = true
                        self!.popUp.present(in: controller)
                        
                    }
                }
            }
        }
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["txtLocation" : txtLocation,
                                     "mapView" : mapView,
                                     "lblOr" : lblOr,
                                     "imgMarker" : imgMarker,
                                     "btnAddCourt" : btnAddCourt,
                                     "lblSkip" : lblSkip]
        
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
        
        mapView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
        btnAddCourt.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-virticalPadding-[txtLocation]-virticalPadding-[mapView]-virticalPadding-[lblOr]-virticalPadding-[btnAddCourt]-secondaryVirticalPadding-[lblSkip]", options: [.alignAllCenterX], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_V)
        
        self.addConstraint(NSLayoutConstraint(item: imgMarker, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40))
        
        self.addConstraint(NSLayoutConstraint(item: imgMarker, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 35))
        
        self.addConstraint(NSLayoutConstraint(item: imgMarker, attribute: .centerX, relatedBy: .equal, toItem: mapView, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: imgMarker, attribute: .bottom, relatedBy: .equal, toItem: mapView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        if self.isBackButton {
            lblSkip.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
        else {
            lblSkip.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -virticalPadding).isActive = true
        }
        
        baseLayout.releaseObject()
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    @objc func closePoup(_ sender: UITapGestureRecognizer? = nil) {
        popUp.dismiss()
    }
    
    
    // MARK: - Internal Helpers -
    fileprivate func getPlaceAddress(_ coordinate : CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            
            AppUtility.isNetworkAvailableWithBlock({ (available) in
                if available {
                    self!.showProgressHUD(viewController: self!, title: nil, subtitle: nil)
                    
                    geocoder.reverseGeocodeCoordinate(coordinate) { [weak self] response , error in
                        if self == nil {
                            return
                        }
                        self!.hideProgressHUD()
                        
                        if response != nil {
                            if let address = response?.firstResult() {
                                
                                let place = LocationAddress()
                                
                                let lines = address.lines! as [String]
                                place.locationName = lines.joined(separator: " ")
                                place.locationAddress = lines.joined(separator: " ")
                                place.latitude = address.coordinate.latitude
                                place.longitude = address.coordinate.longitude
                                
                                self!.selectedPlace = place
                            }
                            else {
                                self!.selectedPlace = nil
                            }
                        }
                        else {
                            self!.makeToast("Fail to locate location")
                            self!.selectedPlace = nil
                        }
                    }
                }
                else {
                    self!.makeToast("Fail to locate location")
                    self!.selectedPlace = nil
                }
            })
        }
    }
    
    func displayCourts() {
        
        for (index, court) in arrCourt.enumerated() {
            var marker : GMSMarker! = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(court.latitude)!, longitude: Double(court.longitude)!))
            marker.zIndex = Int32(index)
            marker.snippet = court.homeCourtName
            marker.icon = UIImage(named: "mapMarker")?.maskWithColor(UIColor.init(hex: court.color))
            marker.map = self.mapView
            marker = nil
        }
    }
    
    
    // MARK: - Server Request -
    fileprivate func loadHomeCourtRequest(coordinate : CLLocationCoordinate2D) {
        if !self.isLoadedRequest {
            
            self.mapView.clear()
            self.arrCourt.removeAll()
            self.txtLocation.text = selectedPlace!.locationName
            let circ = GMSCircle(position: CLLocationCoordinate2D(latitude: selectedPlace!.latitude, longitude: selectedPlace!.longitude), radius: General.kCircleRadios * 1609.34)
            circ.fillColor = Color.appIntermidiateBG.withAlpha(0.15)
            circ.strokeColor = Color.appSecondaryBG.withAlpha(0.5)
            circ.strokeWidth = 2.5;
            circ.map = self.mapView
            
            let dictParameter : NSMutableDictionary = NSMutableDictionary()
            
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KUserId), forKey: "userId")
            dictParameter.setValue(AppUtility.getUserDefaultsObjectForKey(UserDefaultKey.KAccessTocken), forKey: "token")
            dictParameter.setValue(coordinate.latitude, forKey: "latitude")
            dictParameter.setValue(coordinate.longitude, forKey: "longitude")

            self.isLoadedRequest = true

            BaseAPICall.shared.postReques(URL: APIConstant.fetchHomeCourts, Parameter: dictParameter, Type: APITask.FetchHomeCourts, completionHandler: { [weak self] (result) in
                if self == nil {
                    return
                }
                
                switch result{
                case .Success(let object, let error):
                    self!.isLoadedRequest = false
                    self!.hideProgressHUD()
                    self!.arrCourt = object as! [Court]
                    self!.displayCourts()
                    self!.makeToast(error!.alertMessage)
                    break
                    
                case .Error(let error):
                    self!.isLoadedRequest = false
                    self!.hideProgressHUD()
                    AppUtility.executeTaskInMainQueueWithCompletion {
                        self?.makeToast(error!.alertMessage)
                    }
                    
                    break
                case .Internet(let isOn):
                    self!.handleNetworkCheck(isAvailable: isOn, insideView: self!)
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
                    self!.hideProgressHUD()
                    
                    AppUtility.setUserDefaultsObject("1" as AnyObject, forKey: UserDefaultKey.KHomeCourtId)
                    
                    self!.makeToast(error!.alertMessage, duration: ToastManager.shared.duration, position: ToastManager.shared.position, title: nil, image: nil, style: ToastManager.shared.style, completion: { [weak self] (tappable) in
                        if self == nil {
                            return
                        }
                        
                        if let controller : SelectHomeCourtController = self!.getViewControllerFromSubView() as? SelectHomeCourtController {
                            if controller.isBackButton == true {
                                _ = controller.navigationController?.popViewController(animated: true)                                
                            }
                            else {
                                AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
                                    if self == nil {
                                        return
                                    }
                                    AppUtility.getAppDelegate().displayDashboardViewOnWindow()
                                }
                            }
                        }
                        
                    })
                    break
                    
                case .Error(let error):
                    
                    self!.hideProgressHUD()
                    self?.makeToast(error!.alertMessage)
                    
                    break
                case .Internet(let isOn):
                    self!.handleNetworkCheck(isAvailable: isOn, insideView: self!)
                    break
                }
            })
        }
    }
}

extension SelectHomeCourtView : UITextFieldDelegate {
    
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


// MARK: - CLLocationManagerDelegate
extension SelectHomeCourtView : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.isIndoorEnabled = true
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            mapView.settings.compassButton = true
            mapView.settings.indoorPicker = true
            
            locationManager.startUpdatingLocation()
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
            self.isLoadedRequest = false
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 10.0, bearing: 5.5, viewingAngle: 2.2)
            locationManager.stopUpdatingLocation()
        }
    }
}



// MARK: - GMSMapViewDelegate
extension SelectHomeCourtView : GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        if isDrag {
            self.getPlaceAddress(position.target)
            return
        }
        self.isDrag = true
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let controller : SelectHomeCourtController = self.getViewControllerFromSubView() as? SelectHomeCourtController {
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
//        self.isDrag = false
//        return false
        mapView.selectedMarker = marker
        return true
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        return false
    }
    
}


extension SelectHomeCourtView: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith  place: GMSPlace) {
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
            
            self!.mapView.camera = GMSCameraPosition(target: place.coordinate, zoom: 10.8, bearing: 5.5, viewingAngle: 2.2)
            
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


// MARK: - CourtDetailViewDelegate
extension SelectHomeCourtView : CourtDetailViewDelegate {
    func setAsHomeCourtdidTapped(_ courtDetail: Court) {
        
        
        if AppUtility.isUserLogin() {
            self.setHomeCourtRequest(homeCourtId: courtDetail.homeCourtId)
        }
        else {
            if let controller : SelectHomeCourtController = self.getViewControllerFromSubView() as? SelectHomeCourtController {
                self.forceToLoginPopUp = BaseAlertController(iTitle: "Login Required", iMassage: "You must login to set Home Court", iButtonTitle: "Login", index: -1)
                self.forceToLoginPopUp.delegate = self
                self.popUp = STPopupController.init(rootViewController: self.forceToLoginPopUp)
                self.popUp.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closePoup(_:))))
                self.popUp.navigationBarHidden = true
                self.popUp.hidesCloseButton = true
                self.popUp.present(in: controller)
            }
        }
    }
    
    func SeeTheredidTapped(_ courtDetail: Court) {
        if let controller : SelectHomeCourtController = self.getViewControllerFromSubView() as? SelectHomeCourtController {
            controller.navigationController?.pushViewController(HomeViewController(isBackButton: true, courtId : courtDetail.homeCourtId), animated: true)
        }
    }
}


// MARK: - BaseAlertViewDelegate
extension SelectHomeCourtView : BaseAlertViewDelegate {
    func didTappedOkButton(_ alertView: BaseAlertController) {
        if self.forceToLoginPopUp != nil && self.forceToLoginPopUp == alertView {
            self.forceToLoginPopUp = nil
            AppUtility.getAppDelegate().displayLoginViewOnWindow()
        }
    }
}
