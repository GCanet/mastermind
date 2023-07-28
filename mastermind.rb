class Mastermind
  attr_accessor :colores_dispo, :clave_length, :resultado, :solucion, :guess

  def initialize
    @colores_dispo = ['R', 'A', 'N', 'V', 'T', 'M']
    @clave_length = 4
    @resultado = '____'
    @guess = ''
    @solucion = []
    @breaker = Breaker.new(self)
    @maker = Maker.new(self)
  end

  def playinicial
    loop do
      puts 'Si quieres adivinar introduce una A, si quieres que te adivinen introduce una M (a/m):'
      awnser = gets.chomp.downcase
      if awnser == 'a'
        puts 'Empieza el juego, tú adivinas!:'
        @breaker.turnos_breaker
      elsif awnser == 'm'
        puts 'Empieza el juego, la máquina te adivina!:'
        @maker.turnos_maker
      end
    end
  end

  def game_rules
    @resultado = ''
    for i in 0..(@clave_length - 1)
      if @solucion[i] == @guess[i]
        @resultado += 'O'
      elsif @guess.join.include?(@solucion[i])
        @resultado += 'X'
      end
      @resultado += '_'
    end
    puts 'Si la posición es correcta, se mostrará "O", si existe pero no está en orden, será "X":'
    puts @resultado
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
  attr_accessor

  def initialize(mastermind)
    @mastermind = mastermind
  end

  def clave_human
    loop do
      puts 'Introduzca su clave, colores disponibles: Rojo, Amarillo, Negro, Verde, Turquesa, Marrón::'
      @mastermind.solucion = gets.chomp.upcase.split('')
      if @mastermind.solucion.length != @mastermind.clave_length
        puts "Su clave debe tener #{@mastermind.clave_length} caracteres."
        next
      end
      if !@mastermind.solucion.index{ |x| !@mastermind.colores_dispo.include?(x) }.nil?
        puts "Su clave debe contener los siguientes colores: #{@mastermind.colores_dispo}."
        next
      end
      return
    end
  end

  def turnos_maker
    clave_human
    for i in 1..12
      if @mastermind.solucion == @mastermind.guess
        puts 'Lá máquina ha descifrado su clave, GAME OVER!!!'
        @mastermind.game_over
      end
      puts "Intento #{i} de 12."
      computer_guess
      @mastermind.game_rules
    end
    puts 'Se acabaron los intentos de la máquina, TÚ GANAS!!!'
    @mastermind.game_over
  end

  def computer_guess
    resultado_array = @mastermind.resultado.split('')
    new_guess = []
    old_guess = @mastermind.guess.split('')

    for i in 0..(@mastermind.clave_length - 1)
      if resultado_array[i] == 'X'
        new_guess[i].rotate! -1
      elsif resultado_array[i] == '_'
        new_guess[i] = ['R', 'A', 'N', 'V', 'T', 'M'].sample
      elsif resultado_array[i] == 'O'
        new_guess[i] = old_guess[i]
      end
    end
    @mastermind.guess = new_guess.join
    puts "La máquina prueba con: #{new_guess.join}."
  end
end

class Breaker
  attr_accessor

  def initialize(mastermind)
    @mastermind = mastermind
  end

  def computer_choice
    for i in 1..@mastermind.clave_length
      @mastermind.solucion.push(@mastermind.colores_dispo.sample)
    end
    puts @mastermind.solucion
    puts 'La máquina ya a pensado en su combinación! Ahora adivinala!'
  end

  def user_guess
    loop do
      puts 'Introduzca su conjetura, colores disponibles: Rojo, Amarillo, Negro, Verde, Turquesa, Marrón:'
      @mastermind.guess = gets.chomp.upcase.split('')
      if @mastermind.guess.length != @mastermind.clave_length
        puts "Su conjetura debe tener #{@mastermind.clave_length} caracteres."
        next
      end
      if !@mastermind.guess.index{ |x| !@mastermind.colores_dispo.include?(x) }.nil?
        puts "Su conjetura debe contener los siguientes colores: #{@mastermind.colores_dispo}."
        next
      end
      if @mastermind.solucion == @mastermind.guess
        puts 'Tenemos un ganador!!!'
        @mastermind.game_over
      end
      return
    end
  end

  def turnos_breaker
    computer_choice
    for i in 1..12
      puts "Intento #{i} de 12."
      user_guess
      @mastermind.game_rules
    end
    puts 'Se acabaron tus intentos, GAME OVER!!!'
    @mastermind.game_over
  end
end

new_game = Mastermind.new
new_game.playinicial
