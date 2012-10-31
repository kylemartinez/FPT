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
end


def time_elapse(&block)
  start = Time.now
  block.call
  puts "ELASPE #{Time.now - start}"
end

f = Fib.new
puts "Running fib_no_bueno..."
#time_elapse{ puts f.fib_no_bueno(35) }

puts "\n\n"
puts "Rubbing fib_bueno"
#time_elapse{ puts f.fib_bueno(35) }





class RgbHex
attr :hex2rgb, :rgb2hex
  def rgb2hex_manual_cache(rgb)
    @rgb2hex ||= Hash.new do |colors, value|
      colors[value] = value.map { |e| "%02x" % e }.join
    end
    @rgb2hex[rgb]
  end

  def hex2rgb_manual_cache(hex)
    @hex2rgb ||= Hash.new do |colors, value|
      r,g,b = value[0..1], value[2..3], value[4..5]
      colors[value] = [r,g,b].map { |e| e.to_i(16) }
    end
    @hex2rgb[hex]
  end
end


puts "\n\n"
puts "RGB Hex"
#time_elapse{ puts f.fib_bueno(35) }

r = RgbHex.new
puts r.rgb2hex_manual_cache([255,255,255])