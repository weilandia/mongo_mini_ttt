class InitialGameState < GameState
  def self.seed(player:, spaces:)
    raise ArgumentError unless Math.sqrt(spaces) % 1 == 0
    raise ArgumentError unless player.upcase.start_with?(/[X, O]/)

    game_state = InitialGameState.new(current_player: player.upcase, board: Array.new(spaces), moves: [])
    generate_moves(game_state)
  end

  def self.generate_moves(game_state)
    next_player = (game_state.current_player == "X" ? "O" : "X")

    game_state.board.each_with_index do |player_at_position, position|
      unless player_at_position
        next_board = game_state.board.dup
        next_board[position] = game_state.current_player

        next_game_state = GameState.new(current_player: next_player, board: next_board, moves: [])
        game_state.moves << { board: next_game_state.board, moves: next_game_state.moves, current_player: next_game_state.current_player }
        game_state.save!
        generate_moves(next_game_state)
      end
    end
  end
end
