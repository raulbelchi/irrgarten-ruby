# frozen_string_literal: true

require_relative '../game'
require_relative '../UI/textUI'
require_relative '../Controller/controller'

include Irrgarten
include UI
include Control


@juego = Game.new(2, true)
@vista = TextUI.new
@controlador = Controller.new(@juego, @vista)

@controlador.play

