require './config/environment'
 

use Rack::MethodOverride
use ClientController
use ProjectController
use ManagerController

run ApplicationController
