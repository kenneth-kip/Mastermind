module Message
  def play_again
    "Congratulations! You guessed the sequence #{@secret} in #{@trials} " \
    'guesses over . Do you want to (p)lay again or (q)uit?'
  end

  def try_again(input, match_count, pos_count, trials)
    "'#{input}' has #{match_count} of the correct elements with #{pos_count}" \
    " charecters in the correct positions. You have taken #{trials} guess"
  end

  def opening_statement
    'I have generated a beginner sequence with four elements made up of: ' \
    '(r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.' \
    ' Whats your guess?'
  end

  def instruct_user
    'Just Play, You will fugure out the rest. Hope You are ready !!!'
  end

  def cheat(answer)
    "No scrubs(cheater) but anywayz No hard feelings. Here is the answer #{answer}"
  end

  def quit
    'You quit! Loser!'
  end

  def short_input
    'Your input is too short!'
  end

  def long_input
    'Your input is too long'
  end
end
