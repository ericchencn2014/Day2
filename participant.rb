require_relative 'my_observable'
require_relative 'auditor'
require_relative 'oracle.rb'

# Tries to guess the 'secret' number using several different strategies
class Participant
  include MyObservable
  attr_reader :num_attempts
  attr_accessor :name, :age, :used_strategy, :status

  def initialize(oracle, max_num_attempts:10)
    @oracle, @max_num_attempts = oracle, max_num_attempts
    @num_attempts = 0
    super()
  end

  def send_alert(p_status)
    @status = p_status
    notify_observers
  end

  def reset
    @num_attempts = 0
  end

  def play_randomly(lower,upper)
    num = Kernel.rand(lower..upper)
    @num_attempts+=1
    while @oracle.is_this_the_number?(num)!=:correct && (@num_attempts <= @max_num_attempts) do
      # puts "#{__method__}:I guessed #{num}"
      num = Kernel.rand(lower..upper)
      @num_attempts+=1
    end
    if (@num_attempts <= @max_num_attempts)
      # puts "#{__method__}: Yippee, I guessed #{num} and won!"
      send_alert("succeeded")
      :success
    else
      send_alert("failed")
      fail
    end
  end

  def play_linear(lower)
    num=lower
    @num_attempts+=1
    ## puts"num_attempts: #{@num_attempts}"
    while @oracle.is_this_the_number?(num)!=:correct && (@num_attempts <= @max_num_attempts) do
      # puts "#{__method__}:I guessed #{num}"
      num+=1
      @num_attempts+=1
      ## puts"num_attempts: #{@num_attempts}"
    end
    if (@num_attempts <= @max_num_attempts)
      #puts "#{__method__}: Yippee, I guessed #{num} and won!"
      send_alert("succeeded")
      :success
    else
      send_alert("failed")
      fail
    end
  end

  def play_smart_random(lower, upper)
    num = Kernel.rand(lower..upper)
    @num_attempts+=1
    while ((result = @oracle.is_this_the_number?(num)) != :correct) && (@num_attempts <= @max_num_attempts) do
      # puts "#{__method__}: I guessed #{num}"
      if result == :less_than
        upper = num-1
      elsif result == :greater_than
        lower = num+1
      end
      num = Kernel.rand(lower..upper)
      @num_attempts+=1
    end
    if (@num_attempts <= @max_num_attempts)
      # puts "#{__method__}: Yippee, I guessed #{num} and won!"
      send_alert("succeeded")
      :success
    else
      send_alert("failed")
      fail
    end
  end

  def play_binary_search(lower, upper)
    num = (lower+upper)/2
    @num_attempts+=1
    while ((result = @oracle.is_this_the_number?(num)) != :correct) && (@num_attempts <= @max_num_attempts) do
      # puts "#{__method__}:I guessed #{num}"
      if result == :less_than
        upper = num-1
      elsif result == :greater_than
        lower = num+1
      end
      num=(lower+upper)/2
      @num_attempts+=1
    end
    if (@num_attempts <= @max_num_attempts)
      # puts "#{__method__}: Yippee, I guessed #{num} and won!"
      send_alert("succeeded")
      :success
    else
      send_alert("failed")
      fail
    end
  end

  private
  def fail
    # puts "Boo hoo. I made #{@num_attempts} attempts and failed."
    :fail
  end

end
