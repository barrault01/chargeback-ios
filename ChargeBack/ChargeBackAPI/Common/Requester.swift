//
//  Requester.swift
//  ChargeBack
//
//  Created by Antoine Barrault on 16/03/2017.
//  Copyright © 2017 Antoine Barrault. All rights reserved.
//

import Foundation

struct Requester {

    static internal func makingPostRequest(urlInString: String,
                                           params: [String: Any]?,
                                           parser: @escaping ([String: Any]) -> Void) -> URLSessionDataTask? {
        guard let req = postRequest(urlInString: urlInString, params: params) else { return nil }
        return making(request: req, parser: parser)
    }

    static internal func makingGettRequest(urlInString: String,
                                           parser: @escaping ([String: Any]) -> Void) -> URLSessionDataTask? {
        guard let req = getRequest(urlInString: urlInString) else { return nil }
        return making(request: req, parser: parser)
    }

    static private func making(request: URLRequest,
                               parser: @escaping ([String: Any]) -> Void) -> URLSessionDataTask? {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let error = error {
                print(error)
                return
            }
            if let json = self.parseData(data: data) {
                parser(json)
            }

        }
        task.resume()
        return task
    }

    static private func httpRequest(urlInString: String, httpMethod: String) -> URLRequest? {
        guard let url = URL(string: urlInString) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }

    static private func postRequest(urlInString: String, params: [String: Any]?) -> URLRequest? {
        var request = httpRequest(urlInString: urlInString, httpMethod: "POST")
        if let params = params {
            request?.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }
        return request
    }

    static private func getRequest(urlInString: String) -> URLRequest? {
        let request = httpRequest(urlInString: urlInString, httpMethod: "GET")
        return request
    }

    static fileprivate func parseData(data: Data?) -> [String: Any]? {
        guard let data = data else { return nil }
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json
        } catch {
            print("Error during deserialization:\(error)")
            return nil
        }
    }
}

// MARK: Mocked Helper
extension Requester {

    static func pathForJsonFile(with name: String) -> String? {
        let bundle = ChargeBackInstance.bundle()
        guard let path = bundle.path(forResource: name, ofType: "json") else {
            return nil
        }
        return path
    }

    static func urlForPathOfJsonFile(with name: String) -> URL? {
        if let path = pathForJsonFile(with: name) {
            return URL(fileURLWithPath: path)
        }
        return nil
    }

    static func mockedJSON(with name: String) -> Data? {
        if let url = urlForPathOfJsonFile(with: name) {
            let jsonData = try? Data(contentsOf: url, options: Data.ReadingOptions.mappedIfSafe)
            return jsonData
        }
        return nil
    }

    static func mockedEnpoint(jsonName: String, parser: @escaping ([String: Any]) -> Void) {
        if let data = mockedJSON(with: jsonName),
            let json = self.parseData(data: data) {
            parser(json)
        }
    }

}
