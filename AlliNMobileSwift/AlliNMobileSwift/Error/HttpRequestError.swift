//
//  HttpRequestError.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 07/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
enum HttpRequestError : Error {
    case ConnectionError;
    case RequestError;
    case InvalidParameters;
    case InvalidToken;
    case InvalidJson;
    case WebServiceError;
    case UnknownError;
}
