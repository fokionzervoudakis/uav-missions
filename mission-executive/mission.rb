#!/usr/bin/env ruby

$path = File.dirname(__FILE__)

require "#{$path}/util"

module Mission
  def self.execute(assets)
    while !assets.empty?
      assets.each do |asset|
        asset.execute
        assets.delete(asset) if asset.completed?
      end
    end
  end
end

execute do |operation|
  puts "executing #{operation}..."
  Mission.execute(OpLoader.new(operation).assets)
end

