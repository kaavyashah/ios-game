//
//  SplunkLogger.swift
//  codeology game
//
//  Created by Sai Kapuluru on 8/2/19.
//  Copyright © 2019 Kaavya Shah. All rights reserved.
//

import Foundation
import SplunkMint


enum LogLevel: Int {
    case Info
    case Debug
    case Warning
    case Error
    case Notice
    case Critical
    case Alert
    case Emergency
}


class SplunkLogger {
    
    // MARK: Initialization
    
    static let shared: SplunkLogger = {
        let logger = SplunkLogger()
        logger.initializeLoggingFramework()
        return logger
    }()
    
    private func initializeLoggingFramework() {
        // init Splunk MINT SDK
        #if DEBUG
        Mint.sharedInstance().applicationEnvironment = SPLAppEnvDevelopment
        Mint.sharedInstance().enableDebugLog(true)
        #else
        Mint.sharedInstance().applicationEnvironment = SPLAppEnvRelease
        #endif
        
        // HEC_TOKEN and URL taken from here - https://jira.sephora.com/browse/ES-12523
        //Mint.sharedInstance().initAndStartSession(withHECUrl: "http://tewuvaqspl01.sephoraus.com:8088/services/collector/mint", token: "CD12D862-97BC-4C0D;-A470-843E44B7F54D")
        Mint.sharedInstance().initAndStartSession(withAPIKey: "522b4d64")
    }
    
    // MARK: Public Interface
    
    func logHardwareInfo() {
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
        //            var extraData = [String: String]()
        //
        //            extraData["WiFi SSID"] = MPSNetworkUtilities.fetchWiFiSSID()
        //            extraData["IP Address"] = MPSNetworkUtilities.getIP()
        //            extraData["App version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        //            extraData["App build"] = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        //            extraData["TRConnector lib version"] = TenderRetailConnector.shared().libVersion
        //            extraData["TRConnector lib date"] = TenderRetailConnector.shared().libDate
        //            extraData["VMF version"] = TenderRetailConnector.shared().getVMFVersion()
        //            //            extraData["Sled hardware version"] = TenderRetailConnector.shared().getSledHWVersion()
        //            extraData["Firmware info"] = TenderRetailConnector.shared().getFirmwareInfo()
        //            extraData["Sled battery status"] = "\(TenderRetailConnector.shared().getBatteryStatus(CurrentLevel))"
        //
        //            self?.logEvent(name: "Hardware info", level: .Info, extraData: extraData)
        //        }
        
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 3) {
            var extraData = [String: String]()
            
//            extraData["WiFi SSID"] = NetworkUtilities.fetchWiFiSSID()
//            extraData["IP Address"] = NetworkUtilities.getIP()
//            extraData["App version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
//            extraData["App build"] = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
//            extraData["TRConnector lib version"] = TenderRetailConnector.shared().libVersion
//            extraData["TRConnector lib date"] = TenderRetailConnector.shared().libDate
//            extraData["VMF version"] = TenderRetailConnector.shared().getVMFVersion()
//            extraData["Sled hardware version"] = TenderRetailConnector.shared().getSledHWVersion()
//            extraData["Firmware info"] = TenderRetailConnector.shared().getFirmwareInfo()
//            extraData["Sled battery status"] = "\(TenderRetailConnector.shared().getBatteryStatus(CurrentLevel))"
            
            DispatchQueue.main.async { [weak self] in
                self?.logEvent(name: "Hardware info", level: .Info, extraData: extraData)
            }
        }
    }
    
    func sendCachedEventsImmediately() {
        Mint.sharedInstance().flush()
    }
    
    func logEvent(name: String, level: LogLevel) {
        // MPSConfigFetcher.config?.loggingEnabled can be nil if a config file is not downloaded yet
        //if ConfigFetcher.config?.loggingEnabled ?? true {
            let deviceName = UIDevice.current.name
            Mint.sharedInstance().logEvent(withName: "*\(deviceName)*  " + name,
                                           logLevel: convert(logLevel: level) )
        //}
    }
    
    func logEvent(name: String, level: LogLevel, extraData: [String: String]) {
        // MPSConfigFetcher.config?.loggingEnabled can be nil if a config file is not downloaded yet
        //if ConfigFetcher.config?.loggingEnabled ?? true {
            let deviceName = UIDevice.current.name
            Mint.sharedInstance().logEvent(withName: "*\(deviceName)*  " + name,
                                           logLevel: convert(logLevel: level),
                                           extraData: convert(extraData: extraData) )
        //}
    }
    
    // MARK: Private Implementation
    
    private init() {
        
    }
    
    private func convert(logLevel: LogLevel) -> MintLogLevel {
        let mintLogLevel: MintLogLevel
        
        switch logLevel {
        case .Info:
            mintLogLevel = InfoLogLevel
        case .Debug:
            mintLogLevel = DebugLogLevel
        case .Warning:
            mintLogLevel = WarningLogLevel
        case .Error:
            mintLogLevel = ErrorLogLevel
        default:
            mintLogLevel = InfoLogLevel
        }
        
        return mintLogLevel
    }
    
    private func convert(extraData: [String: String]) -> MintLimitedExtraData {
        let mintExtraData = MintLimitedExtraData()
        for (key,value) in extraData {
            mintExtraData.setValue(value, forKey: key)
        }
        
        return mintExtraData
    }
    
}

