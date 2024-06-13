import Fluent
import Vapor

final class TodoModel: Model, Content {
    static let schema = "todo"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "completed")
    var completed: Bool

    init() { }

    init(id: UUID? = nil, title: String, completed: Bool) {
        self.id = id
        self.title = title
        self.completed = completed
    }
}
