module Inputable
  VALID_ANSWERS = ['hit', 'stay', 'h', 's']
  def input_hit_or_stay
    answer = ''

    loop do
      answer = gets.chomp.downcase
      break if valid_answer?(answer)
      puts "Please give a valid answer!"
      puts "Type \"hit\" (or \"h\") \"stay\" (or \"s\"):"
    end

    answer == 'h' || answer == 'hit'
  end

  def valid_answer?(answer)
    VALID_ANSWERS.include?(answer)
  end
end