func fetchData(completion: @escaping (Result<[Data], Error>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        guard let data = data else {
            completion(.failure(NSError(domain: "com.example.app", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received from server."]))) 
            return
        }
        do {
            let result = try JSONDecoder().decode([Data].self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }.resume()
}