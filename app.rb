# Gem stuff
dev_gems = %w(wirble map_by_method mongrel)
test_gems = %w(test-spec)

dev_gems.each { |g| gem g, :group => "development" }
test_gems.each { |g| gem g, :group => "test" }

gem 'mysql2'

# Database Stuff

file 'config/database.example.yml', <<-CODE
  # SQLite version 3.x
  #   gem install sqlite3-ruby (not necessary on OS X Leopard)
  development:
    adapter: sqlite3
    database: db/development.sqlite3
    timeout: 5000

  # Warning: The database defined as "test" will be erased and
  # re-generated from your development database when you run "rake".
  # Do not set this db to the same as development or production.
  test:
    adapter: sqlite3
    database: db/test.sqlite3
    timeout: 5000

  production:
    adapter: sqlite3
    database: db/production.sqlite3
    timeout: 5000


  # MYSQL Setup
  # development:
  #   adapter: mysql2
  #   database: development
  #   pool: 5
  #   username: 
  #   password: 
  #   host: localhost
  #   socket: /tmp/mysql.sock
  # 
  # # Warning: The database defined as 'test' will be erased and
  # # re-generated from your development database when you run 'rake'.
  # # Do not set this db to the same as development or production.
  # test:
  #   adapter: mysql2
  #   database: test
  #   pool: 5
  #   username: 
  #   password: 
  #   host: localhost
  #   socket: /tmp/mysql.sock
  # 
  # production:
  #   adapter: mysql2
  #   database: production
  #   pool: 5
  #   username: 
  #   password: 
  #   host: localhost
  #   socket: /tmp/mysql.sock
CODE

file 'config/database.production.yml', <<-DB
  production:
    adapter: mysql
    database: production
    username: 
    password: 
    host: localhost
DB

# Javascript stuff

file 'public/javascripts/application.js', <<-JS

function load_fx () {
  // body...
}

$(document).ready(function() {
  load_fx()
});

// setup the remote class
$('a.remote').live('click', function(event){

  link = $(this).attr('href');

  $.ajax({
    type: "GET",
    url: link,
    dataType: "script"
  });

  return false;
});

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")} 
})

JS

remove_file "public/index.html"
remove_file "config/database.example.yml"

git :init
run "echo 'config/database.yml' >> .gitignore"
run "echo 'config/database.production.yml' >> .gitignore"
git :add => "."

notes = <<-NOTES
  
  Run the following steps to complete the setup of #{app_name.humanize}:
  
  > cd #{app_name}
  > gem install bundler # if not installed
  > bundle install
  > rails server
  
NOTES

log notes

# If you have textmate, why don't we just launch it?
run "mate ." if system("mate")