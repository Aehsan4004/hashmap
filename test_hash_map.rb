# test_hash_map.rb

require_relative 'hash_map'

# Test HashMap
test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts "Initial entries: #{test.entries.inspect}"
puts "Initial length: #{test.length}"
puts "Initial capacity: #{test.capacity}"
puts "Initial load factor: #{test.load_factor}"
puts "Initial load level: #{test.size.to_f / test.capacity}"

# Overwrite some nodes
test.set('apple', 'green')
test.set('dog', 'black')
puts "\nAfter overwriting 'apple' and 'dog':"
puts "Entries: #{test.entries.inspect}"
puts "Length: #{test.length}"
puts "Capacity: #{test.capacity}"

# Add one more to trigger resize
test.set('moon', 'silver')
puts "\nAfter adding 'moon' (should resize):"
puts "Entries: #{test.entries.inspect}"
puts "Length: #{test.length}"
puts "Capacity: #{test.capacity}"
puts "New load level: #{test.size.to_f / test.capacity}"

# Overwrite some nodes again
test.set('banana', 'green')
test.set('frog', 'blue')
puts "\nAfter overwriting 'banana' and 'frog':"
puts "Entries: #{test.entries.inspect}"
puts "Length: #{test.length}"
puts "Capacity: #{test.capacity}"

# Test other methods
puts "\nTesting other methods:"
puts "Get 'carrot': #{test.get('carrot')}"
puts "Has? 'elephant': #{test.has?('elephant')}"
puts "Has? 'zebra': #{test.has?('zebra')}"
puts "Remove 'grape': #{test.remove('grape')}"
puts "Entries after remove: #{test.entries.inspect}"
puts "Length: #{test.length}"
puts "Keys: #{test.keys.inspect}"
puts "Values: #{test.values.inspect}"

# Test clear
test.clear
puts "\nAfter clear:"
puts "Entries: #{test.entries.inspect}"
puts "Length: #{test.length}"
puts "Capacity: #{test.capacity}"

# Test HashSet
puts "\nTesting HashSet:"
set = HashSet.new
set.add('apple')
set.add('banana')
puts "Set keys: #{set.keys.inspect}"
puts "Has? 'apple': #{set.has?('apple')}"
puts "Has? 'banana': #{set.has?('banana')}"
puts "Remove 'banana': #{set.remove('banana')}"
puts "After remove: #{set.keys.inspect}"
puts "Length: #{set.length}"