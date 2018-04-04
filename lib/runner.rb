require './lib/mastermind'
require 'colorize'

class Runner
  def initialize
    @sessions = 0
  end

  def run
    open_game if @sessions.zero?
    response = nil
    until response && %i[quit won input_error].include?(response.status)
      input = user_input
      response = Mastermind.new.execute(input)
      @sessions += 1
      puts response.message
    end
    return run if play_again? response
    puts '**' * 18 + 'Goodbye!'.colorize(:light_blue) + '**' * 18
  end

  def user_input
    correct_inputs = %w[p play i instructions q quit]
    input = prompt
    unless correct_inputs.include? input
      puts 'Follow instructions !!!'
      return user_input
    end
    input
  end

  def prompt
    print '=======>  '
    gets.chomp
  end

  def play_again?(response)
    return false if response.status == :quit
    true
  end

  def open_game
    border_box
    opening_remarks
    border_box
  end

  def border_box
    puts '_' * 80
    puts '_' * 80
  end

  def opening_remarks
    welcome_msg = 'Welcome to Mastermind'.colorize(:light_blue)
    commands = 'Would you like to (p)lay, read the (i)nstructions, or (q)uit?'.colorize(:light_blue)
    play = ' Ready to play '.colorize(background: :red)
    puts '**' + ' ' * 25 + welcome_msg + ' ' * 30 + '**'
    puts '**' + ' ' * 9 + commands + ' ' * 6 + '**'
    puts '**' + ' ' * 28 + play + ' ' * 33 + '**'
  end
end
