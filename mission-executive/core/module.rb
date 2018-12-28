class Module
  def defensive_copy(*method_names)
    method_names.each do |name|
      define_method(name) do
        var = instance_variable_get("@#{name}")
        Array.new(var.class == Array ? var : var.values)
      end
    end
  end
end

