//
//  APIClient.swift
//  SportsMax
//
//  Created by Hussein Jaber on 30/11/2020.
//

import Foundation
import UIKit

/**
 **List of URLSession error codes*:
 kCFURLErrorUnknown   = -998,
 kCFURLErrorCancelled = -999,
 kCFURLErrorBadURL    = -1000,
 kCFURLErrorTimedOut  = -1001,
 kCFURLErrorUnsupportedURL = -1002,
 kCFURLErrorCannotFindHost = -1003,
 kCFURLErrorCannotConnectToHost    = -1004,
 kCFURLErrorNetworkConnectionLost  = -1005,
 kCFURLErrorDNSLookupFailed        = -1006,
 kCFURLErrorHTTPTooManyRedirects   = -1007,
 kCFURLErrorResourceUnavailable    = -1008,
 kCFURLErrorNotConnectedToInternet = -1009,
 kCFURLErrorRedirectToNonExistentLocation = -1010,
 kCFURLErrorBadServerResponse             = -1011,
 kCFURLErrorUserCancelledAuthentication   = -1012,
 kCFURLErrorUserAuthenticationRequired    = -1013,
 kCFURLErrorZeroByteResource        = -1014,
 kCFURLErrorCannotDecodeRawData     = -1015,
 kCFURLErrorCannotDecodeContentData = -1016,
 kCFURLErrorCannotParseResponse     = -1017,
 kCFURLErrorInternationalRoamingOff = -1018,
 kCFURLErrorCallIsActive               = -1019,
 kCFURLErrorDataNotAllowed             = -1020,
 kCFURLErrorRequestBodyStreamExhausted = -1021,
 kCFURLErrorFileDoesNotExist           = -1100,
 kCFURLErrorFileIsDirectory            = -1101,
 kCFURLErrorNoPermissionsToReadFile    = -1102,
 kCFURLErrorDataLengthExceedsMaximum   = -1103,
 
 */

func printD(_ items: Any...) {
    #if DEBUG
    print(items)
    #endif
}

// Please when you change this, change it also inside VideoPlayer+FRM.swift
enum Endpoint {
    static let staging = "https://weiss-digicel-uat.azdio-tv.com"
    static let prod = "https://weiss.sportsmax.digicelgroup.com"
    // ----> Please when you change this, change it also inside VideoPlayer+DRM.swift <-----
    static let main = prod
    // ----> Please when you change this, change it also inside VideoPlayer+DRM.swift <-----
}

class APIClient {
    
    func genericRequest<T: Codable>(forRequest request: Request, forType type: T.Type,
                                    result: @escaping (Result<T, APIError>) -> Void) {
        let session = URLSession.shared
        
        do {
            
            let urlRequest = try prepareUrlRequest(forRequest: request)
            
            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                
                if let error = error {
                    if (error as NSError).code == -1009 || (error as NSError).code == -1020 {
                        result(.failure(.noInternetConnection))
                    } else {
                        result(.failure(.error(error)))
                    }
                    
                    return
                }
                
                guard let data = data else {
                    result(.failure(.unknown))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    result(.failure(.unknown))
                    return
                }
                
                #if DEBUG
                if let jsonResult = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    let dict = ["path": request.privatePath,
                                "parameters": request.parameters,
                                "method": request.method] as [String : Any]
                    dict.forEach({
                        print($0)
                    })
                    print(jsonResult)
                }
                #endif
                switch httpResponse.statusCode {
                case 200...204:
                    if request.responseType == .data {
                        result(.success(data as! T))
                        return
                    } else {
                        do {
                            if T.self == Bool.self {
                                DispatchQueue.main.async {
                                    if let drmTokenString = httpResponse.allHeaderFields["drmtoken"] as? String {
                                        DRMTokenManager.shared.setNewToken(drmTokenString: drmTokenString)
                                    }
                                    result(.success(true as! T))
                                }
                            } else {
                                let decodedJson = try JSONDecoder().decode(T.self, from: data)
                                DispatchQueue.main.async {
                                    result(.success(decodedJson))
                                }
                            }
                        } catch {
                            #if DEBUG
                            print(error)
                            #endif
                            result(.failure(.jsonDecodingFailure))
                        }
                    }
                case 401:
                    APIInterceptor.shared.addFailedRequest {
                        self.genericRequest(forRequest: request, forType: T.self, result: result)
                    }
                case 403:
                    result(.failure(.forbidden))
                case 406:
                    result(.failure(.inAppFailure))
                case 412:
                    result(.failure(.subscriptionExpired))
                case 400...499:
                    result(.failure(.clientError))
                case 509:
                    result(.failure(.bandwidthLimitExceeded))
                case 500...599:
                    result(.failure(.serverError))
                default:
                    result(.failure(.unknown))
                }
            }
            task.resume()
        } catch _ {}
    }
    
    
    
    private func prepareUrlRequest(forRequest request: Request) throws -> URLRequest {
        let fullUrlString: String
        if UserManager.isLoggedIn {
            fullUrlString = Endpoint.main + request.privatePath
        } else {
            fullUrlString = Endpoint.main + request.publicPath
        }
        guard let url = URL(string: fullUrlString) else {
            throw APIError.badUrl
        }
        var urlRequest = URLRequest(url: url)
        
        switch request.parameters {
        case .body(let params):
            guard let params = params else {
                throw APIError.badBodyParams
            }
            let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
        case .multiPart(let params):
            guard let params = params else {
                throw APIError.badBodyParams
            }
            multiFormDataHTTPBody(forRequest: &urlRequest, parameters: params)
        case .url(let params):
            guard let params = params as? [String: String] else {
                throw APIError.badURLParams
            }
            urlParameters(forRequest: &urlRequest, urlString: fullUrlString, parameters: params)
        case .noParams:
            break
        }
        
        request.headers?.forEach {
            urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key)
        }

        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        if !UIDevice.uuid.isEmpty {
            urlRequest.addValue(UIDevice.uuid, forHTTPHeaderField: APIKeys.mdwDeviceUuid.rawValue)
        }

        if let appVersion = Bundle.appVersion, !appVersion.isEmpty {
            urlRequest.addValue(appVersion, forHTTPHeaderField: APIKeys.mdwAppVersion.rawValue)
        }

        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpShouldHandleCookies = true
        return urlRequest
    }
    
    /// Create boundary string for multipart/form-data request
    ///
    /// - returns:            The boundary string that consists of "Boundary-" followed by a UUID string.
    private func generateBoundaryString() -> String {
        "Boundary-\(UUID().uuidString)"
    }
    
    
    /// Generates url parameters for a given request
    /// - Parameters:
    ///   - request: Instance of URLRequest where we want to add the parameters
    ///   - urlString: The url string
    ///   - parameters: Dictionary of parameters
    private func urlParameters(forRequest request: inout URLRequest, urlString: String,
                               parameters: [String: String]) {
        let queryParams = parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        guard var components = URLComponents(string: urlString) else {
            fatalError()
        }
        // in case some params were already passed in the url, we retain them in the if statement
        if let existingQueryParams = components.queryItems {
            components.queryItems = queryParams + existingQueryParams
        } else {
            components.queryItems = queryParams
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.url = components.url
    }
    
    private func multiFormDataHTTPBody(forRequest request: inout URLRequest, parameters: [String: Any]) {
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createBody(with: parameters as? [String: String], boundary: boundary)
    }
    
    /// Create body of the `multipart/form-data` request
    ///
    /// - parameter parameters:   The optional dictionary containing keys and values to be passed to web service.
    /// - parameter filePathKey:  The optional field name to be used when uploading files. If you supply paths, you must supply filePathKey, too.
    /// - parameter urls:         The optional array of file URLs of the files to be uploaded.
    /// - parameter boundary:     The `multipart/form-data` boundary.
    ///
    /// - returns:                The `Data` of the body of the request.
    private func createBody(with parameters: [String: String]?, boundary: String) -> Data {
        var body = Data()
        
        parameters?.forEach { (key, value) in
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        
        body.append("--\(boundary)--\r\n")
        return body
    }
}


extension Data {
    
    /// Append string to Data
    ///
    /// Rather than littering my code with calls to `data(using: .utf8)` to convert `String` values to `Data`, this wraps it in a nice convenient little extension to Data. This defaults to converting using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `Data`.
    
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
