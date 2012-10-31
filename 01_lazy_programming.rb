
#lambda examples
x = lambda { return "lambda example" }

raise ArgumentError.new "this should not run" unless x.call == "lambda example"

four = lambda { 4 }

five = four.call + 1
raise ArgumentError.new "this should not run" unless five == 5

three = four.call - 1
raise ArgumentError.new "this should not run" unless three == 3

twenty = four.call * 5
raise ArgumentError.new "this should not run" unless twenty == 20

#&block in method examples
def method_block(&block)
  block.call
end

raise ArgumentError.new "this should not run" unless method_block { 1 + 1 } == 2
raise ArgumentError.new "this should not run" unless method_block { "foobar" } == "foobar"

x = method_block do
  a_string = "this string"
  a_string += " was created"
  a_string += " in a block"
  a_string
end

raise ArgumentError.new "this should not run" unless x == "this string was created in a block"


#class examples
class Square
  attr_accessor :width, :height, :counter, :area

  def initialize(w, h)
    @counter = 0
    @width = w
    @height = h
  end

  def area
    @area ||= calculate_area
  end

  def calculate_area
    @counter += 1
    @height * @width
  end
end

square = Square.new(10, 10)
raise ArgumentError.new "this should not run" unless square.counter == 0
square.area
raise ArgumentError.new "this should not run" unless square.counter == 1
square.area
raise ArgumentError.new "this should not run" unless square.counter == 1


class Lazy < BasicObject

  def initialize(&block)
    @computation = block
  end

  def __run_method__
    if @computation
      @result = @computation.call
      @computation = nil
    end
    @result
  end

  def method_missing(*a, &b)
    __run_method__.__send__(*a, &b)
  end
end

def foo
  "bar"
end

bar = Lazy.new { foo }
raise ArgumentError.new "this should not run" unless bar.eql? "bar"

num = Lazy.new { 5 }
raise ArgumentError.new "this should not run" unless (num + 5) == 10
raise ArgumentError.new "this should not run" unless (num * 2) == 10
raise ArgumentError.new "this should not run" unless (num - 5) == 0


class BiggerSquare

  attr_accessor :width, :height, :counter, :area

  def initialize(w, h)
    @counter = 0
    @width = w
    @height = h
    @area = Lazy.new {calculate_area}
  end

  def calculate_area
    @counter += 1
    @height * @width
  end
end

big_square = BiggerSquare.new(10, 10)
raise ArgumentError.new "this should not run" unless big_square.area.eql? 100
raise ArgumentError.new "this should not run" unless big_square.counter == 1

big_square.area
raise ArgumentError.new "this should not run" unless big_square.counter == 1



