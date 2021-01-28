require_relative "tempo_preparo"

puts "Calculadora de tempo de pereparo do miojo"

puts "Insita o tempo da ampulheta maior"
amp_a = gets.chomp.to_i

puts "Insita o tempo da ampulheta menor"
amp_b = gets.chomp.to_i

puts "Insita o tempo de cozimento do miojo"
miojo = gets.chomp.to_i

tempo_total = temp_prep(amp_a, amp_b, miojo)

puts tempo_total ? "O tempo total necessário é #{tempo_total}" : "Não é possível obter o tempo com esses valore"