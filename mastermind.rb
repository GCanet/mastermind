# guess.index{ |x| !solucion.include?(x) }.nil?
# Clase para definir el juego y el jugador de la maquina
class Mastermind
  attr_accessor :solucion

  def initialize
    @colores_dispo = ['R', 'A', 'N', 'V', 'T', 'M']
    @clave_length = 4
    @solucion = []
    @resultado = ''
    @guess = []
  end

  def computer_choice
    for i in 1..@clave_length
      @solucion.push(@colores_dispo.sample)
    end
    puts @solucion
  end

  def user_guess
    loop do
      puts 'Introduzca su conjetura:'
      @guess = gets.chomp.upcase
      if @guess.length != @clave_length
        puts "Su conjetura debe tener #{@clave_length} caracteres."
        next
      end
      if !@guess.split('').index{ |x| !@colores_dispo.include?(x) }.nil?
        puts "Su conjetura debe contener los siguientes colores: #{@colores_dispo}."
        next
      end
    end
    if @solucion == @guess
      puts We have a winner!
    end
  end

  def play
    computer_choice
    for i in 1..12
      user_guess
      game_rules
    end
  end

  def game_rules
    for i in 0..@clave_length
      if @solucion[i] == @guess[i]
        puts punto rojo
        @resultado += 'O'
      elsif @solucion[i] == @guess[0] || @guess[1] || @guess[2] || @guess[3]
        puts punto blanco
        @resultado += 'X'
      end
    end
    puts @resultado
  end
end

new_game = Mastermind.new
new_game.play
