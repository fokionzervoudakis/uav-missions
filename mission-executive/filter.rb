module Filter
  def method_added(name)
    return if @filtering # do not add filters to original_ methods
    return if name.eql?(:initialize)

    @filtering = true

    alias_method("original_#{name}", name)

    define_method(name) do |*args|
      puts 'callee:'
      puts "  #{self.class.name}.#{name} (#{self.object_id})"
      puts 'call stack:'
      caller_locations(1).each { |level| puts "  #{level.path}:#{level.lineno}:in `#{level.label}'" }
      puts
      self.send("original_#{name}", *args)
    end

    @filtering = false
  end
end

