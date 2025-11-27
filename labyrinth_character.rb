# frozen_string_literal: true

module Irrgarten
  class LabyrinthCharacter

      private_class_method :new
      attr_reader :row, :col, :intelligence, :strength, :health
      attr_writer :health

      def initialize(name, intelligence, strength, health) 
        @name = name
        @intelligence = intelligence
        @strength = strength
        @health = health
      end

      def copiar(other)
        @name = "Player #{other.number}"
        @intelligence = other.intelligence
        @strength = other.strength
        @health = other.health
        @row = other.row
        @col = other.col
      end

      #PREGUNTAR
      def labyrinth_character(other)
        @name = other.name
        @intelligence = other.intelligence
        @strength = other.strength
        @health = other.health
      end

      def dead
        if @health<=0
          return true
        else
          return false
        end
      end

      def set_pos(row, col)
        @row = row
        @col = col
      end

      def to_s
        return "{name=#{@name}, intelligence=#{@intelligence}, strength=#{@strength}, health=#{@health}, row=#{@row}, col=#{@col}"
      end

      def got_wounded
        @health-=1
      end

      def attack
        raise NotImplementedError, "Debes implementar este método en la clase hija"
      end

      def defend(attack)
        raise NotImplementedError, "Debes implementar este método en la clase hija"
      end

  end
end