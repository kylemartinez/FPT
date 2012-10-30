
#gem install memoizable
require 'memoizable'

class Test
  include Memoizable
  def hey(number)
    puts "hello there"
    number
  end

  memoize :hey
end

x = Test.new
x.hey(5)
x.hey(5)


module Memoizable
  def memoize( name, cache = Hash.new )
    original = "__unmemoized_#{name}__"
    ([Class, Module].include?(self.class) ? self : self.class).class_eval do
      alias_method original, name
      private original
      define_method(name) { |*args| cache[args] ||= send(original, *args) }
    end
  end
end