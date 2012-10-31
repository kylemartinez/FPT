require 'memoizable'

class Fib

  attr :series

  def initialize
    @series = [0,1]
  end

  def fib_no_bueno(n)
    return n if (0..1).include? n
    fib_no_bueno(n-1) + fib_no_bueno(n-2)
  end


  def fib_bueno(n)
    @series[n] ||= fib_bueno(n-1) + fib_bueno(n-2)
  end

  include Memoizable
  def fib_mem(n)
    return n if (0..1).include? n
    fib_mem(n-1) + fib_mem(n-2)
  end

  memoize :fib_mem
end

def time_elapse(&block)
  start = Time.now
  block.call
  puts "ELASPE #{Time.now - start}"
end

f = Fib.new
puts "Running fib_no_bueno..."
time_elapse{ puts f.fib_no_bueno(35) }

puts "\n\n"
puts "Running fib_bueno"
time_elapse{ puts f.fib_bueno(35) }


#puts "\n\n"
#puts "Running fib_mem"
#time_elapse{ puts f.fib_mem(35) }
