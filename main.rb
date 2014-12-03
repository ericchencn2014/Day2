
# Evaluate the performance of participants using different guessing strategies

require_relative 'oracle.rb'
require_relative 'participant.rb'
require_relative 'auditor'

NUM_OF_RUNS = 8
NUM_OF_AUDITORS = 1

oracle = Oracle.new

# evaluate random strategy
total_num_attempts = 0
total_num_failures = 0
homer = Participant.new(oracle, max_num_attempts: NUM_OF_RUNS*2)
homer.name = 'homer'

=begin
# Creating an instance of Proc
#update_block = Proc.new {|player| puts "#{player.name} #{player.status} in guessing the number."}
update_block = Proc.new do |name, num_attempts|
  # No need to pass entire instance of Participant class, since only 2 fields are needed here.
  # Passing all of the object would expose all of its instance variables and methods.
  if num_attempts <= 5
    #puts "#{name} is not genuine."
  else
    puts "#{name} is genuine: No of attempts required: #{num_attempts}."
  end
end

#Creates object of Auditor class
=end

auditor_obj = Auditor.new("Jamie", 0)
# Add them to observer list of homer
homer.add_observer(auditor_obj)

1.upto(NUM_OF_RUNS) do |i|
  oracle.secret_number = i
  homer.reset
  if homer.play_randomly(1,NUM_OF_RUNS)==:success
    # puts "play randomly found #{i} in #{homer.num_attempts} attempts"
    total_num_attempts += homer.num_attempts
  else
    # puts "play randomly failed to find #{i} after #{homer.num_attempts} attempts"
    total_num_failures += 1
  end
end
puts "play randomly took on average #{total_num_attempts/(NUM_OF_RUNS-total_num_failures)} attempts to succeed"



# evaluate linear strategy
total_num_attempts = 0
total_num_failures = 0
bart = Participant.new(oracle, max_num_attempts:NUM_OF_RUNS*2)
bart.name = "bart"
bart.add_observer(auditor_obj)

1.upto(NUM_OF_RUNS) do |i|
  oracle.secret_number = i
  bart.reset
  if bart.play_linear(1)==:success
    # puts "play_linear found #{i} in #{bart.num_attempts} attempts"
    total_num_attempts += bart.num_attempts
  else
    # puts "play_linear failed to find #{i} after #{bart.num_attempts} attempts"
    total_num_failures += 1
  end
end
puts "play_linear took on average #{total_num_attempts/(NUM_OF_RUNS-total_num_failures)} attempts to succeed"

# evaluate 'smart random' strategy
total_num_attempts = 0
total_num_failures = 0
maggie = Participant.new(oracle, max_num_attempts:NUM_OF_RUNS*5)
maggie.name = "maggie"
maggie.add_observer(auditor_obj)

1.upto(NUM_OF_RUNS) do |i|
  oracle.secret_number = i
  maggie.reset
  if maggie.play_smart_random(1,NUM_OF_RUNS)==:success
    # puts "play_smart_random found #{i} in #{maggie.num_attempts} attempts"
    total_num_attempts += maggie.num_attempts
  else
    # puts "play_smart_random failed to find #{i} after #{maggie.num_attempts} attempts"
    total_num_failures += 1
  end
end
puts "play_smart_random took on average #{total_num_attempts/(NUM_OF_RUNS-total_num_failures)} attempts to succeed"

# evaluate binary search strategy
total_num_attempts = 0
total_num_failures = 0
lisa = Participant.new(oracle, max_num_attempts:NUM_OF_RUNS*5)
lisa.name = "lisa"
lisa.add_observer(auditor_obj)

1.upto(NUM_OF_RUNS) do |i|
  oracle.secret_number = i
  lisa.reset
  if lisa.play_binary_search(1,NUM_OF_RUNS)==:success
    # puts "play_binary_search found #{i} in #{lisa.num_attempts} attempts"
    total_num_attempts += lisa.num_attempts
  else
    # puts "play_binary_search failed to find #{i} after #{lisa.num_attempts} attempts"
    total_num_failures += 1
  end
end
puts "play_binary_search took on average #{total_num_attempts/(NUM_OF_RUNS-total_num_failures)} attempts to succeed"


