require 'colorize'

class Response
  attr_reader :message, :status

  def initialize(inputs)
    @status  = inputs[:status]
    @message = color_message inputs[:message]
  end

  def color_message(message)
    case
    when %i[won open].include?(@status) then  message.colorize(:green)
    when @status == :try_again then message.colorize(:yellow)
    when %i[quit input_error].include?(@status) then message.colorize(:red)
    when %i[cheat instruct].include?(@status) then message.colorize(:blue)
    else message
    end
  end
end
