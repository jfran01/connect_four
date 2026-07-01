require_relative '../lib/board'

describe Board do
  let(:board) { Board.new }
  describe "#check_player_choice" do
    context 'when choice is in an in-range number and not full' do
      it 'assigns choice to column_choice' do
        chosen_column = 1
        symbol = 'X'
        expect{board.check_player_choice(chosen_column, symbol)}.to change{board.board}
      end
    end
    context 'when choice is out of range' do
      it 'returns false' do
        chosen_column = 9
        symbol = 'X'
        expect(board.check_player_choice(chosen_column, symbol)).to eq(false)
      end
    end
    context 'when choice is NaN' do
      it 'returns false' do
        chosen_column = 'A'.to_i - 1
        symbol = 'X'
        expect(board.check_player_choice(chosen_column, symbol)).to eq(false)
      end
    end
    context 'when column is full' do
      it 'returns false' do
        chosen_column = 2
        symbol = 'X'
        board.instance_variable_set(:@board, [[nil, nil, 1], [nil, nil, 1], [nil, nil, 1]])
        expect(board.check_player_choice(chosen_column, symbol)).to eq(false)
      end
    end
  end
end