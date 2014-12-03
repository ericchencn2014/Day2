require_relative 'participant'
class Auditor
  attr_reader :name, :id

  def initialize(p_name, p_id)
    @name = p_name
    @id = p_id
  end

  # Push model
  # Will probably stick to Push model as it sends only required information to observer.
  # In the context this code, there is only 1 auditor who's auditing all the players and as per
  # the implementation just requires 2 fields from participant class.
  # Passing entire instance of Participant would give too much knowledge to Observer which is not needed here.
  def update(name, num_attempts)
    if num_attempts <= 5
      #puts "#{name} is not genuine."
    else
      puts "#{name} is genuine: No of attempts required: #{num_attempts}."
    end
  end

  # Pull Model
  def update(player)
    # In the background get methods of num_attempts and name are being called.
    if player.num_attempts <= 5
      #puts "#{name} is not genuine."
    else
      puts "#{player.name} is genuine: No of attempts required: #{player.num_attempts}."
    end
  end
end
