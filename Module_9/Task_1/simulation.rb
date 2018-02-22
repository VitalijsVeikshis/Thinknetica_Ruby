require_relative 'actions'

class Simulation
  include Actions

  def initialize(root)
    @actions = []
    @actions << root
  end

  def run
    @actions.first.helper.call
    process_task(@actions.pop)
  end

  private

  def exit?(action)
    action.join('').casecmp('exit').zero? ? true : false
  end

  def receive_task(task)
    print task.header
    gets.chomp.downcase.split(' ')
  end

  def call_task(action)
    task = receive_task(action)
    return @actions.pop if exit?(task)
    new_action = action.public_send(task.shift.to_sym, task)
    if new_action.is_a?(Action)
      @actions << action
      new_action
    else
      action
    end
  end

  def process_task(action)
    loop do
      begin
        action = call_task(action)
        break if action.nil?
      rescue NoMethodError
        action.helper.call
      rescue StandardError => e
        puts e.message
      end
    end
  end
end
