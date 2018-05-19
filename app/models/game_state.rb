class GameState
  include Mongoid::Document

  field :current_player, type: String
  field :moves, type: Array
  field :board, type: Array
end
