#!/usr/bin/env ruby

require "#{File.dirname(__FILE__)}/template_util"

class ClassLoader < OpLoader; defensive_copy :actions end
class LidarAction; include ActionUtil end

module PropertyTemplate
  def self.generate(actions)
    properties = String.new

    actions.each do |action|
      property = get_property(action)
      properties += (properties.empty? ? 'd' : ' & d') + "#{property}=0" unless property.nil?
    end

    puts "P=? [ F #{properties} ]"
  end

  private
    def self.get_property(action)
      if action.is_kinetic_action?
        case action.type
          when :default_singleton,
               :default_terminal,
               :terminal_observer,
               :terminal_constrained_observer,
               :terminal_subject_constraint
            action.id
        end
      end
    end
end

execute do |operation|
  puts "properties for #{operation}..."
  PropertyTemplate.generate(ClassLoader.new(operation).actions)
end

