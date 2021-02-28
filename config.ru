require './config/environment'
 

use Rack::MethodOverride
use UserController
use ProjectController
use ManagerController

run ApplicationController
