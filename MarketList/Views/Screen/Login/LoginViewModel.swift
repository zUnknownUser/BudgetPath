//
//  LoginViewModel.swift
//  MarketList
//
//  Created by Lucas Amorim on 03/02/25.
//

//

import Alamofire
import SwiftUI
import UIKit

class LoginViewModel: ObservableObject {
    @Published var user: String = ""
    @Published var errorMessage: String = ""
    
    //    func getDeviceIdentifier() -> ResponseObject {
    //        let platform: String = UIDevice.current.systemName
    //        let systemVersion: String = UIDevice.current.systemVersion
    //        let deviceModel: String = UIDevice.current.model
    //
    //        print("\(platform) --------- \(deviceModel) -------- \(systemVersion)")
    //
    //        return ResponseObject(platform: platform, systemVersion: systemVersion, deviceModel: deviceModel)
    //    }
    
    func actionLogin(email: String, password: String, name: String, completion: @escaping (Bool) -> Void) {
        print("Starting login process...")
        
        //        let identifier = getDeviceIdentifier()
        
        let params: [String: Any] = [
            "email": email,
            "password": password,
            "name": name
        ]
        
        //        let headers: HTTPHeaders = [
        //            "identificador-dispositivo": "request-\(identifier.platform)",
        //            "Content-Type": "application/json"
        //        ]
        //
        //        print("Request Params: \(params)")
        //        print("Request Headers: \(headers)")
        
        AF.request("http://192.168.8.198:5171/api/v1/User/registerSystem",
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default
        )
        .responseDecodable(of: LoginResponse.self) { response in
            let statusCode = response.response?.statusCode ?? -1
            print("Response Status Code: \(statusCode)")
            
            guard (200...299).contains(statusCode) else {
                print("HTTP Error: Received status code \(statusCode)")
                DispatchQueue.main.async {
                    self.errorMessage = "Erro na requisição: status code \(statusCode)"
                    completion(false)
                }
                return
            }
            
            if let responseData = response.data {
                print("Raw Response Data: \(String(data: responseData, encoding: .utf8) ?? "Invalid data format")")
            } else {
                print("No response data received.")
            }
            
            switch response.result {
            case .success(let loginResponse):
                print("API Response: \(loginResponse)")
                
                if ((loginResponse.token?.isEmpty) == nil) {
                    print("JWT Token recebido: \(String(describing: loginResponse.token))")
                    DispatchQueue.main.async {
                        self.user = "Usuário logado com sucesso!"
                        completion(true)
                    }
                } else {
                    print("Erro: Nenhum token retornado.")
                    DispatchQueue.main.async {
                        self.errorMessage = "Erro: Nenhum token recebido."
                        completion(false)
                    }
                }
                
            case .failure(let error):
                print("Erro na requisição: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.errorMessage = "Erro na requisição: \(error.localizedDescription)"
                    completion(false)
                }
            }
        }
    }
}
