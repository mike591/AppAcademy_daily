require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    link = Link.new
    @head = link
    @tail = link
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.val.nil? && @tail.val.nil?
  end

  def get(key)
    each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    each do |link|
      return true if link.key == key
    end
    false
  end

  def append(key, val)
    last_link = last
    new_link = Link.new(key, val)

    if @tail == @head && @head.val == nil && @head.key == nil
      @head = new_link
      @tail = new_link
    else
      last_link.next = new_link
      new_link.prev = last_link
      @tail = new_link
    end

  end

  def update(key, val)
    each do |link|
      if link.key == key
        link.val = val
        return link
      end

    end

  end

  def remove(key)
    each do |link|
      if link.key == key
        if link == @head && link == @tail
          dummy_link = Link.new
          @head = dummy_link
          @tail = dummy_link
        elsif link == @head
          @head = link.next
          @head.prev = nil
        elsif link == @tail
          @tail = link.prev
          @tail.next = nil
        elsif link.key == key
          next_link = link.next
          prev_link = link.prev

          next_link.prev = prev_link
          prev_link.next = next_link

        end
      end

    end
  end

  def each(&prc)
    current = @head
    until current == nil || current.key == nil
      prc.call(current)
      current = current.next
    end
  end

  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
