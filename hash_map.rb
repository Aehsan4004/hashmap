# hash_map.rb

# Node class used by both HashMap and HashSet
class Node
  attr_accessor :key, :value, :next_node

  def initialize(key, value)
    @key = key
    @value = value
    @next_node = nil
  end
end

# HashSet class (only stores keys)
class HashSet
  attr_reader :load_factor, :capacity, :buckets, :size

  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(@capacity) { nil }
    @size = 0
  end

  def hash(key)
    raise ArgumentError, "Key must be a string" unless key.is_a?(String)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code % @capacity
  end

  def add(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    if @buckets[index].nil?
      @buckets[index] = Node.new(key, nil)  # Value is nil
      @size += 1
    else
      current = @buckets[index]
      while current
        return if current.key == key  # Key already exists, no change
        current = current.next_node
      end
      new_node = Node.new(key, nil)
      new_node.next_node = @buckets[index]
      @buckets[index] = new_node
      @size += 1
    end

    resize if (@size.to_f / @capacity) > @load_factor
  end

  def has?(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length
    current = @buckets[index]
    while current
      return true if current.key == key
      current = current.next_node
    end
    false
  end

  def remove(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length
    current = @buckets[index]
    return nil if current.nil?
    if current.key == key
      @buckets[index] = current.next_node
      @size -= 1
      return key
    end
    while current.next_node
      if current.next_node.key == key
        current.next_node = current.next_node.next_node
        @size -= 1
        return key
      end
      current = current.next_node
    end
    nil
  end

  def length
    @size
  end

  def clear
    @buckets = Array.new(@capacity) { nil }
    @size = 0
  end

  def keys
    result = []
    @buckets.each do |bucket|
      current = bucket
      while current
        result << current.key
        current = current.next_node
      end
    end
    result
  end

  private

  def resize
    old_keys = keys
    @capacity *= 2
    @buckets = Array.new(@capacity) { nil }
    @size = 0
    old_keys.each { |key| add(key) }
  end
end

# HashMap class (stores key-value pairs)
class HashMap
  attr_reader :load_factor, :capacity, :buckets, :size

  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(@capacity) { nil }
    @size = 0
  end

  def hash(key)
    raise ArgumentError, "Key must be a string" unless key.is_a?(String)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code % @capacity
  end

  def set(key, value)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    if @buckets[index].nil?
      @buckets[index] = Node.new(key, value)
      @size += 1
    else
      current = @buckets[index]
      while current
        if current.key == key
          current.value = value
          return
        end
        current = current.next_node
      end
      new_node = Node.new(key, value)
      new_node.next_node = @buckets[index]
      @buckets[index] = new_node
      @size += 1
    end

    resize if (@size.to_f / @capacity) > @load_factor
  end

  def get(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length
    current = @buckets[index]
    while current
      return current.value if current.key == key
      current = current.next_node
    end
    nil
  end

  def has?(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length
    current = @buckets[index]
    while current
      return true if current.key == key
      current = current.next_node
    end
    false
  end

  def remove(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length
    current = @buckets[index]
    return nil if current.nil?
    if current.key == key
      @buckets[index] = current.next_node
      @size -= 1
      return current.value
    end
    while current.next_node
      if current.next_node.key == key
        deleted_value = current.next_node.value
        current.next_node = current.next_node.next_node
        @size -= 1
        return deleted_value
      end
      current = current.next_node
    end
    nil
  end

  def length
    @size
  end

  def clear
    @buckets = Array.new(@capacity) { nil }
    @size = 0
  end

  def keys
    result = []
    @buckets.each do |bucket|
      current = bucket
      while current
        result << current.key
        current = current.next_node
      end
    end
    result
  end

  def values
    result = []
    @buckets.each do |bucket|
      current = bucket
      while current
        result << current.value
        current = current.next_node
      end
    end
    result
  end

  def entries
    result = []
    @buckets.each do |bucket|
      current = bucket
      while current
        result << [current.key, current.value]
        current = current.next_node
      end
    end
    result
  end

  private

  def resize
    old_entries = entries
    @capacity *= 2
    @buckets = Array.new(@capacity) { nil }
    @size = 0
    old_entries.each { |key, value| set(key, value) }
  end
end

# Test HashSet (moved to test file or separate execution)