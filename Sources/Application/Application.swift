import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import KituraOpenAPI

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public class App {
  let router = Router()
  let cloudEnv = CloudEnv()
  
  public init() throws {
    // Run the metrics initializer
    initializeMetrics(router: router)
    Persistence.setUp()
  }
  
  func postInit() throws {
    // Endpoints
    initializeHealthRoutes(app: self)
    initializeEntryRoutes(app: self)
    initializeUserRoutes(app: self)
    KituraOpenAPI.addEndpoints(to: router)
    router.get("/", handler: helloWorldHandler)
  }
  
  func helloWorldHandler(request: RouterRequest, response: RouterResponse, next: ()->()) {
    response.headers.setType(MediaType.TopLevelType.text.rawValue)
    response.send("Hello, World!")
    next()
  }
  
  public func run() throws {
    try postInit()
    Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
    Kitura.run()
  }
}
