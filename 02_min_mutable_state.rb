# minimize mutable data

# adding elements to an array

# << modifies its receiver

a = [1, 2, 3]
b = a << 1

raise ArgumentError.new "this should not run" unless b == [1, 2, 3, 1]
raise ArgumentError.new "this should not run" unless a == [1, 2, 3, 1]

# + does not modify its receiver

c = a + [2]

raise ArgumentError.new "this should not run" unless c == [1, 2, 3, 1, 2]
raise ArgumentError.new "this should not run" unless b == [1, 2, 3, 1]
raise ArgumentError.new "this should not run" unless a == [1, 2, 3, 1]


def naive_map(array)
  array.each_with_object([]) {|e, obj| obj << yield(e)}
end

a = [1, 2, 3, 4]
b = naive_map(a) {|x| x + 1}

raise ArgumentError.new "this should not run" unless a == [1, 2, 3, 4]
raise ArgumentError.new "this should not run" unless b == [2, 3, 4, 5]


def recursive_naive_map(array, &block)
  if array.empty?
    []
  else
    [ yield(array[0])] + recursive_naive_map(array[1..-1], &block)
  end
end

def inject_naive_map(array, &block)
  array.inject([]) {|base, e| [ yield(e)] + base}
end

a = [1, 2, 3, 4] * 20
n = 100000

#Naive Map Time Trial
start = Time.now
n.times { naive_map(a) {|x| x + 1} }
puts "naive_map: #{Time.now - start}"

#Recursive Naive Map
start = Time.now
n.times { recursive_naive_map(a) {|x| x + 1} }
puts "recursive_naive_map: #{Time.now - start}"

#Inject Naive Map
start = Time.now
n.times { inject_naive_map(a) {|x| x + 1} }
puts "recursive_naive_map: #{Time.now - start}"

