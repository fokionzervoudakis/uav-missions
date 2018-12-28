#!/usr/bin/env ruby

class String
  def strip_comments(marker)
    self.include?(marker) ? self[0, (self =~ Regexp.new(marker)) + marker.size] : self
  end
end

lambda {
    dtmc_tokens = {
    :comments => ['//'],
    :identifiers => [/(_|[a-z])[0-9]/],
    :keywords => [
      :bool,
      :const,
      :dtmc,
      :endmodule,
      :false, :formula,
      :init, :int,
      /mod\(/, /^module/,
      :true
    ],
    :operators => [
      /[!&*+<=?|]| \/ /,
      /(?<=[^-])>/, # greater than
      /-(?=[^>])/ # minus
    ],
    :separators => [/[(),:;\['\]]|\.\.|->/],
    :values => [
      /(\+|-|\.|=|= |>|\[)[0-9]/,
      /(?<=[^=]) [0-9];/
    ]
  }

  pctl_tokens = {
    :identifiers => [/[a-z]([0-9]|>)/],
    :keywords => [:F, /mod\(/],
    :operators => [:P, /[!&=>?]/],
    :separators => [/[(),\[\]]/],
    :values => [/(=|>)[0-9]/]
  }

  yaml_tokens = {
    :comments => ['#'],
    :keywords => [
      /^Action/, :ARDrone, :Asset, :actions,
      :concurrencies,
      :duration,
      :HoverAction, :Hummingbird,
      /id:/, :interval,
      :LidarAction,
      :PhotoSurveillanceAction, :preconditions,
      :TraversePathSegmentAction
    ],
    :separators => [/[,\-:\[\]]/],
    :values => [/( |\[)-?[0-9]/]
  }

  Kernel.send(:define_method, :count_tokens) do |extensions, path|
    extensions.each do |extension|
      puts extension

      Dir[path + extension.to_s].each do |file|
        tokens =
          case extension
            when :pctl
              pctl_tokens
            when :pm
              dtmc_tokens
            when :yaml
              yaml_tokens
          end
        total = 0

        File.open(file).each do |line|
          line = line.strip_comments(tokens[:comments][0]) if tokens.has_key?(:comments)

          tokens.each_pair do |key, value|
            value.each { |token| total += line.scan(token.is_a?(Symbol) ? token.to_s : token).size }
          end
        end

        puts "#{File.basename(file, '.*')} #{IO.readlines(file).size} #{total}"
      end
    end
  end
}.call

PATH = "#{File.dirname(__FILE__)}/../"
count_tokens([:yaml], "#{PATH}mission_execution_engine/operations/operation_*.")
count_tokens([:pctl, :pm], "#{PATH}models/operation_**/*.")

