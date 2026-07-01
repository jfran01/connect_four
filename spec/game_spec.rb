require_relative '../lib/game'

describe Game do
  let(:game) { described_class.new }

  describe '#change_player' do
    it 'changes the current player' do
      expect { game.change_player }.to(change { game.current_player })
    end
  end

  describe '#play_game' do
    before do
      allow(game).to receive(:play_round)
      allow(game).to receive(:check_for_winner)
      allow(game).to receive(:check_for_draw)
      allow(game.instance_variable_get(:@player_one)).to receive(:choose_symbol)
      allow(game.instance_variable_get(:@player_two)).to receive(:choose_symbol)
    end

    it 'ends game if there is a winner' do
      allow(game).to receive(:check_for_winner).and_return(false, true)
      game.play_game
      expect(game).to have_received(:play_round).twice
    end

    it 'ends game if there is a draw' do
      allow(game).to receive(:check_for_draw).and_return(false, true)
      game.play_game
      expect(game).to have_received(:play_round).twice
    end
  end
end
