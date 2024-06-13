import Fluent

struct CreateTodo: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("todos")
            .id()
            .field("title", .string)
            .field("completed", .bool)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("todos").delete()
    }
}


struct TodoMigation: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("todo")
            .id()
            .field("title", .string)
            .field("completed", .bool)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("todo").delete()
    }
}
