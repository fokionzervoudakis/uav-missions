require 'yaml'

require "#{$path}/filter"

Dir["#{$path}/core/*"].each { |file| require file }

require "#{$path}/op_loader"
require "#{$path}/subject"
require "#{$path}/observer"
require "#{$path}/action"
require "#{$path}/hover_action"
require "#{$path}/asset"
require "#{$path}/lidar_action"

def execute
  if ARGV[0].eql?('filter') && !ARGV[1].nil?
    yield(File.basename("#{$path}/operations/#{ARGV[1]}", '.yaml'))
  else
    Dir["#{$path}/operations/operation_*"].each { |file| yield(File.basename(file, '.yaml')) }
  end

  puts "#{"="*50}"
end

