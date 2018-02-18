class Action
  def run
    @helper.call
    loop do
      print @header
      command = gets.chomp.downcase
      break if exit?(command)
      command = command.split(' ')
      action = @actions[command.shift.to_sym]
      action.nil? ? @helper.call : action.call(command)
      rescue StandardError => e
        puts e.message
    end
  end

  private

  def exit?(command)
    command.casecmp('exit').zero? ? true : false
  end
end
