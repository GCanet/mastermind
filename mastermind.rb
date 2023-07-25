class Mastermind
  attr_accessor :colores_dispo, :clave_length

  def initialize
    @colores_dispo = ['R', 'A', 'N', 'V', 'T', 'M']
    @clave_length = 4
    @breaker = Breaker.new(self)
    @maker = Maker.new(self)
  end

  def playinicial
    loop do
      puts 'Si quieres adivinar introduce una A, si quieres que te adivinen introduce una M (a/m):'
      awnser = gets.chomp.downcase
      if awnser == 'a'
        puts 'Empieza el juego:'
        @breaker.turnos_breaker
      elsif awnser == 'm'
        puts 'Empieza el juego:'
        @maker.clave_human
      end
    end
  end

  def game_over
    loop do
      puts 'Volver a jugar? (y/n):'
      awnser2 = gets.chomp.downcase
      if awnser2 == 'y'
        playinicial
      elsif awnser2 == 'n'
        exit
      end
    end
  end
end

class Maker
  attr_accessor :solucion, :resultado

  def initialize(mastermind)
    @mastermind = mastermind
    @solucion = []
    @resultado = ''
  end

  def clave_human
    loop do
      puts 'Introduzca su clave:'
      @solucion = gets.chomp.upcase.split('')
      if @solucion.length != @mastermind.clave_length
        puts "Su clave debe tener #{@mastermind.clave_length} caracteres."
        next
      end
      if !@solucion.index{ |x| !@mastermind.colores_dispo.include?(x) }.nil?
        puts "Su clave debe contener los siguientes colores: #{@mastermind.colores_dispo}."
        next
      end
      return
    end
  end

# 12 turnos + seguir normas, no bruteforce
  def computer_rules
  end
end

class Breaker
  attr_accessor :solucion, :resultado

  def initialize(mastermind)
    @mastermind = mastermind
    @solucion = []
    @resultado = ''
  end

  def computer_choice
    for i in 1..@mastermind.clave_length
      @solucion.push(@mastermind.colores_dispo.sample)
    end
    # recordar borrar este puts para q no se vea la solución
    #
    puts @solucion
  end

  def user_guess
    loop do
      puts 'Introduzca su conjetura:'
      @guess = gets.chomp.upcase.split('')
      if @guess.length != @mastermind.clave_length
        puts "Su conjetura debe tener #{@mastermind.clave_length} caracteres."
        next
      end
      if !@guess.index{ |x| !@mastermind.colores_dispo.include?(x) }.nil?
        puts "Su conjetura debe contener los siguientes colores: #{@mastermind.colores_dispo}."
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
      puts "Intento #{i} de 12."
      user_guess
      game_rules
    end
    puts 'Se acabaron tus intentos, GAME OVER!'
    @mastermind.game_over
  end

  def game_rules
    @resultado = ''
    for i in 0..(@mastermind.clave_length - 1)
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
