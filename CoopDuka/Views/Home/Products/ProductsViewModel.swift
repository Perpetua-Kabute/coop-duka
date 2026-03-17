//
//  ProductsViewModel.swift
//  CoopDuka
//
//  Created by Perpetua Kabute    on 17/03/2026.
//
import SwiftUI
import Combine

class ProductsViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var cart: [Product] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var showErrorDialog: Bool = false
    @Published var dialogMessage: String = ""
    @Published var selectedProduct: Product? = nil
    
    @Published var showCartBanner: Bool = false
    @Published var successMessage: Bool = false
    
    var cancellables = Set<AnyCancellable>()

    var filteredProducts: [Product] {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else { return products }
        return products.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    init(){
        fetchProducts()
    }
    func fetchProducts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        self.isLoading = true
        //create a publisher urlsession.shared.datataskpublisher
        //subscribe publisher on a background thread...datataskpublisher is usually already on a background thread
        //receive package on main thread
        //try map to check that the data is good
        //decode data into our model
        //sink (put the item into our app
        //store (cancel subscription of needed)
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [Product].self, decoder: JSONDecoder())
            .sink{ [weak self] (completion) in
                self?.isLoading = false
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error = \(error.localizedDescription)")
                    self?.showErrorDialog = true
                    self?.dialogMessage = error.localizedDescription
                }
                print("COMPLETEON: \(completion)")
            }receiveValue: {[weak self] (products) in
                print(products)
                self?.products = products
                
                
            }
            .store(in: &cancellables)
            
            
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else{
            throw URLError(.badServerResponse)
        }
        return output.data
        
    }
    
    func addProductToCart(product: Product) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.cart.append(product)
            self?.isLoading = false
            
            self?.showCartBanner = true
                    
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.showCartBanner = false
            }
            
            
        
        }
        
        
    }
    
}
