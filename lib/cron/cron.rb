require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require 'faraday'
require 'uri'
require 'base64'
require 'pony'
require_relative './model'
require_relative './processor'




FilePath='/opt/prodapps/db_job/tmp/data.pid' 
puts "==================================="
puts "PID: #{Process.pid}"
_pid=Process.pid
File.open(FilePath, 'w' ){|f| f.write Process.pid}
puts "==================================="


run_schedule

puts "Deleting PID file......"
File.delete(FilePath)


puts "==================================="
puts "Killing PID: #{_pid}"
Process.kill 'TERM', _pid
puts "==================================="
