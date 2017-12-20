import Foundation
import RxCocoa
import RxSwift
import SwiftyJSON
import Alamofire

// 解析数据，没查到 Codable 有 path 的情况怎么解决，我就用 SwiftyJSON 把 path 取出来再 Codable

extension ObservableType where E == DataResponse<Data> {
    
    public func mapJSON(failsOnEmptyData: Bool = true) -> Observable<JSON> {
        return flatMap { response -> Observable<JSON> in
            return Observable.just(try response.mapJSON())
        }
    }
    
    public func mapModel<T: Codable>(_ type: T.Type, path: String? = nil) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapModel(T.self, path: path))
        }
    }
    
    public func mapArray<T: Codable>(_ type: T.Type, path: String? = nil) -> Observable<[T]> {
        return flatMap { Response -> Observable<[T]> in
            return Observable.just(try Response.mapArray(T.self, path: path))
        }
    }

    
}


extension DataResponse where Value == Data {
    
    func mapJSON() throws -> JSON {

        guard let data = self.data else { throw self.error! }
        do {
            let json = try JSON(data: data,
                                options:[
                    JSONSerialization.ReadingOptions.allowFragments,
                    JSONSerialization.ReadingOptions.mutableLeaves]
            )
            return json
        } catch {
            throw NSError(domain: "数据解析错误", code: -0001, userInfo: nil)
        }
    }
    
    func mapModel<T: Codable>(_ type: T.Type, path: String? = nil) throws -> T {
        
        do {
            var json = try self.mapJSON()
            path?.components(separatedBy: ".").forEach { json = json[$0] }
            let decoder = JSONDecoder()
            let data = try json.rawData()
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            throw NSError(domain: "数据解析错误", code: -0001, userInfo: nil)
        }
    }
    
    func mapArray<T: Codable>(_ type: T.Type, path: String? = nil) throws -> [T] {
        
        do {
            var json = try self.mapJSON()
            path?.components(separatedBy: ".").forEach { json = json[$0] }
            let decoder = JSONDecoder()
            let data = try json.rawData()
            let object = try decoder.decode([T].self, from: data)
            return object
        } catch {
            throw NSError(domain: "数据解析错误", code: -0001, userInfo: nil)
        }
    }
}
