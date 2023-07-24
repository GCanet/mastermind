class Mastermind
  attr_accessor :awnser

  def initialize
  end

  def playinicial
    loop do
      puts 'Si quieres adivinar introduce una A, si quieres que te adivinen introduce una M'
      awnser = gets.chomp.downcase
      if awnser == 'a'
        Breaker.turnos_breaker
      elsif awnser == 'm'
        Maker.human_choice
      end
    end
  end
end

class Maker
  attr_accessor :solucion_maker :resultado_maker

  def initialize
    @solucion_maker = []
    @resultado_maker = ''
  end

  def human_choice
  end

  def computer_rules
  end
end

class Breaker
  attr_accessor :solucion :clave_length :colores_dispo :resultado

  def initialize
    @colores_dispo = ['R', 'A', 'N', 'V', 'T', 'M']
    @clave_length = 4
    @solucion = []
    @resultado = ''
  end

  def computer_choice
    for i in 1..@clave_length
      @solucion.push(@colores_dispo.sample)
    end
    # recordar borrar este puts para q no se vea que escoge la maquina
    puts @solucion
  end

  def user_guess
    loop do
      puts 'Introduzca su conjetura:'
      @guess = gets.chomp.upcase.split('')
      if @guess.length != @clave_length
        puts "Su conjetura debe tener #{@clave_length} caracteres."
        next
      end
      if !@guess.index{ |x| !@colores_dispo.include?(x) }.nil?
        puts "Su conjetura debe contener los siguientes colores: #{@colores_dispo}."
        next
      end
      if @solucion == @guess
        puts 'Tenemos un ganador!!!'
        exit
      end
      return
    end
  end

  def turnos_breaker
    computer_choice
    for i in 1..12
      user_guess
      game_rules
    end
  end

  def game_rules
    for i in 0..(@clave_length - 1)
      if @solucion[i] == @guess[i]
        @resultado += 'O'
      elsif @solucion[i] == @guess[0] || @solucion[i] == @guess[1] || @solucion[i] == @guess[2] || @solucion[i] == @guess[3]
        @resultado += 'X'
      end
    end
    puts 'Si la posición es correcta, se mostrará "O", si existe pero no está en orden, será "X":'
    puts @resultado
  end
end

new_game = Mastermind.new
new_game.playinicial
