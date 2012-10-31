# minimize mutable data

def naive_map(array)
  array.each_with_object([]) {|e, obj| obj << yield(e)}
end

a = [1, 2, 3, 4]
b = naive_map(a) {|x| x + 1}

raise ArgumentError.new "this should not run" unless a == [1, 2, 3, 4]
raise ArgumentError.new "this should not run" unless b == [2, 3, 4, 5]


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


