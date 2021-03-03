require './config/environment'
 

use Rack::MethodOverride
use ProjectController
use ManagerController

run ApplicationController
