require './config/environment'
 

use Rack::MethodOverride
use ProjectController
use UsersController

run ApplicationController
