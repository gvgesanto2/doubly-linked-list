class Node
  attr_accessor :value, :prev_node, :next_node

  def initialize(value, prev_node=nil, next_node=nil)
    @value = value
    @prev_node = prev_node
    @next_node = next_node
  end
end

class DoublyLinkedList
  attr_reader :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def empty?
    @size == 0
  end

  def append(value)
    new_node = Node.new(value, @tail)

    if(self.empty?)
      @head = new_node
      @tail = new_node
    else
      @tail.next_node = new_node
      @tail = new_node
    end

    @size += 1
  end

  def shift(value)
    new_node = Node.new(value, nil, @head)

    if(self.empty?)
      @head = new_node
      @tail = new_node
    else
      @head.prev_node = new_node
      @head = new_node
    end

    @size += 1
  end

  def at(index)
    if index < @size / 2
      get_node(index).value
    else
      get_node(index, true).value
    end
  end

  def insert_into(value, index)
    if index == 0
      shift(value)
    elsif index == @size
      append(value)
    else
      new_node = Node.new(value)
      prev_target_node = get_node(index - 1)
      new_node.next_node = prev_target_node.next_node
      new_node.prev_node = prev_target_node
      prev_target_node.next_node = new_node
      prev_target_node.next_node.prev_node = new_node
      @size += 1
    end
  end

  def to_string
    list_str = "[ "
    tmp_node = @head

    while tmp_node != nil
      list_str << "#{tmp_node.value} "
      tmp_node = tmp_node.next_node
    end
  
    list_str << "]"
  end

  private 

  def get_node(index, from_end=false)
    tmp_node = from_end ? @tail : @head

    index.times do
      tmp_node = from_end ? tmp_node.prev_node : tmp_node.next_node
    end

    return tmp_node
  end
end

list = DoublyLinkedList.new

list.append(5)
list.append(2)
list.append(3)
list.append(1)
list.shift(9)
list.insert_into(25, 2)

# [9, 5, 25, 2, 3, 1]

puts list.to_string
puts "List size: #{list.size}" 
puts "Elem at index 1: #{list.at(1)}" 