import Fluent
import Vapor

struct TodoModelController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("todos")

        todos.get(use: { try await self.index(req: $0) })
        todos.post(use: { try await self.create(req: $0) })
        todos.group(":todoID") { todo in
            todo.delete(use: { try await self.delete(req: $0) })
        }
    }
    
    func index(req: Request) async throws -> [TodoModel] {
        try await TodoModel.query(on: req.db).all()
    }

    func create(req: Request) async throws -> TodoModel {
        let todoModel = try req.content.decode(TodoModel.self)

        try await todoModel.save(on: req.db)
        return todoModel
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let todoModel = try await TodoModel.find(req.parameters.get("TodoModelID"), on: req.db) else {
            throw Abort(.notFound)
        }

        try await todoModel.delete(on: req.db)
        return .noContent
    }
}
