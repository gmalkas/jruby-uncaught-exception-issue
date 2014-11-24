#!/usr/bin/env ruby
require 'java'
require 'pry'

Task = Struct.new(:time) do
  include Comparable

  def <=>(other)
    puts "Task#<=> invoked!"
    raise StandardError
    self.time <=> other.time
  end
end

class Queue
  def initialize
    @queue = java.util.PriorityQueue.new(10)
  end

  def push(task)
    @queue.add(task) # invokes Task#<=>
  end
end

# Rescuing exceptions *does not* work as expected when
# the failing Ruby code is only *indirectly* invoked by the rescuing Ruby code
def push_to_queue(queue, item)
  queue.push(item)
rescue Exception => e
  puts "Rescued #{e}"
end

q = Queue.new
t = Task.new(1)
t2 = Task.new(2)

push_to_queue(q, t)
push_to_queue(q, t2)

binding.pry
