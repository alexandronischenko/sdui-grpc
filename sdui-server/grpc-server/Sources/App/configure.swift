import Fluent
import FluentPostgresDriver
import Vapor


// configures your application
public func configure(_ app: Application) throws {

    app.servers.use(.gRPCServer)

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
    ), as: .psql, isDefault: true)

    app.migrations.add(TodoMigation())
    app.migrations.add(CreateTodo())
//    app.autoMigrate()

    try app.autoMigrate().wait()
}
