# Hack to run AR tasks without Rails
module Rails
  def self.root
    File.dirname(__FILE__)
  end

  def self.env
    "production"
  end

  def self.application
    Paths.new
  end
end

class Paths
  def paths
    { "db/migrate" => [File.expand_path("../db/migrate", __FILE__)]  }
  end

  def load_seed
    load File.expand_path("../db/seeds.rb", __FILE__)
  end
end

require 'bundler/setup'
require 'active_record'
require 'pry'
require 'erb'
require 'colorize'

include ActiveRecord::Tasks

db_dir = File.expand_path('../db', __FILE__)
DatabaseTasks.db_dir  = db_dir
DatabaseTasks.env     = "production"
DatabaseTasks.root    = File.dirname(__FILE__)
DatabaseTasks.database_configuration = YAML.load(
  File.read(File.join(db_dir, 'database.yml'))
)
DatabaseTasks.migrations_paths = File.join(db_dir, 'migrate')

task :environment do
  ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
  ActiveRecord::Base.establish_connection DatabaseTasks.env.to_sym
end

load 'active_record/railties/databases.rake'

def invoke(task_name, *args)
  Rake::Task[task_name].invoke *args
end
# Require custom tasks

require_relative 'lib/book_hunter.rb'
rake_path = File.expand_path("../lib/tasks/**/*.rake", __FILE__)
Dir.glob(rake_path).each do |task_file|
  load task_file
 end
