require_relative 'response'
require_relative 'message'
require 'byebug'

# Main program
class Mastermind
  include Message

  attr_accessor :trials, :secret
  attr_reader :name, :stop, :user_input

  def initialize
    @secret = generate_color_sets
    @trials = 0
    @start = Time.now
  end

  def generate_color_sets
    %w[r r g b].permutation(4).to_a.uniq.sample.join
  end

  def instructions; end

  def execute(input)
    if input == 'p'
      puts Response.new(message: opening_statement, status: :open).message
      game_session
    elsif input == 'q'
      user_has_quit
    elsif input == 'i'
      instruct
    end
  end

  def game_session
    puts @secret
    print '=======>  '
    @user_input = gets.chomp
    case @user_input
    when @secret then user_has_won
    when 'q' then user_has_quit
    when 'c' then answer
    else check_wrong_answer
    end
  end

  def user_has_won
    count_trials
    Response.new(message: play_again, status: :won)
  end

  def user_has_quit
    Response.new(message: quit, status: :quit)
  end

  def answer
    puts Response.new(message: cheat(@secret), status: :cheat).message
    game_session
  end

  def instruct
    puts Response.new(message: instruct_user, status: :instruct).message
    puts Response.new(message: opening_statement, status: :open).message
    game_session
  end

  # TODO: fix conditions
  def check_wrong_answer
    count_trials
    return input_short if @user_input.length <= 3
    return input_long if @user_input.length >= 5
    try_again = try_again @user_input, match_count, correct_positions, @trials
    puts Response.new(message: try_again, status: :try_again).message
    game_session
  end

  def count_trials
    @trials += 1
  end

  def match_count
    4 - (@user_input.split('') - @secret.split('')).size
  end

  def correct_positions
    @secret.split('').select.with_index { |val, i| val == @user_input[i] }.size
  end

  def input_short
    puts Response.new(message: short_input, status: :input_error).message
    game_session
  end

  def input_long
    puts Response.new(message: long_input, status: :input_error).message
    game_session
  end
end
