//
//  SubscriptionService.swift
//  StrongBibration
//
//  Created by Vova Kolomyltsev on 31.01.2024.
//

import Foundation
import StoreKit
 
fileprivate enum StoreError: Error {
    case failedVerification
}

@available(iOS 15.0, *)
final class SubscriptionManager: ObservableObject {
    static let shared = SubscriptionManager()
    
    @Published var storeProducts: [Product] = []
    @Published var purchasedSubscriptions : [Product] = []
    
    private var updateListenerTask: Task<Void, Error>? = nil
    private let productDict: [String : String]
    
    init() {
        productDict = SubscriptionsModel.subscriptionInfo
        updateListenerTask = listenForTransactions()
        
        Task {
            await requestProducts()
            await updateCustomerProductStatus()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    private func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    await self.updateCustomerProductStatus()
                    await transaction.finish()
                } catch {
                    print("Transaction failed verification")
                }
            }
        }
    }
    
    private func requestProducts() async {
        do {
            storeProducts = try await Product.products(for: productDict.values)
            
        } catch {
            print("Failed - error retrieving products \(error)")
        }
    }
    
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let signedType):
            return signedType
        }
    }
    
    @MainActor
    private func updateCustomerProductStatus() async {
        var purchasedCourses: [Product] = []
        
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                if let course = storeProducts.first(where: { $0.id == transaction.productID}) {
                    purchasedCourses.append(course)
                }
            } catch {
                print("Transaction failed verification")
            }
            self.purchasedSubscriptions = purchasedCourses
        }
    }
    
    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()

        switch result {
        case .success(let verificationResult):
            let transaction = try checkVerified(verificationResult)
            await updateCustomerProductStatus()
            await transaction.finish()
            
            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }
    
    func restorePurchase() async throws {
        try await AppStore.sync()
    }
}
