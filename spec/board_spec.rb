# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  let(:board) { described_class.new }

  describe '#check_player_choice' do
    let(:symbol) { 'X' }

    before do
      allow(board).to receive(:puts)
    end

    context 'when choice is in an in-range number and not full' do
      let(:chosen_column) { 1 }

      it 'changes the board array' do
        expect { board.check_player_choice(chosen_column, symbol) }.to(change(board, :board))
      end

      it 'stores the index of the relevant row' do
        expect { board.check_player_choice(chosen_column, symbol) }.to change {
          board.instance_variable_get(:@selected_row)
        }.to(-1)
      end
    end

    context 'when choice is out of range' do
      it 'returns false' do
        chosen_column = 9
        expect(board.check_player_choice(chosen_column, symbol)).to be(false)
      end
    end

    context 'when choice is NaN' do
      it 'returns false' do
        chosen_column = 'A'.to_i - 1
        expect(board.check_player_choice(chosen_column, symbol)).to be(false)
      end
    end

    context 'when column is full' do
      it 'returns false' do
        chosen_column = 2
        board.instance_variable_set(:@board, [[nil, nil, 1], [nil, nil, 1], [nil, nil, 1]])
        expect(board.check_player_choice(chosen_column, symbol)).to be(false)
      end
    end
  end

  describe '#four_in_a_row' do
    before do
      board.instance_variable_set(:@selected_row, 1)
      board.instance_variable_set(:@selected_column, 0)
    end

    context 'when all cells are empty' do
      it 'returns false' do
        board.instance_variable_set(:@board, Array.new(6) { Array.new(7) })
        expect(board.four_in_a_row('X')).to be(false)
      end
    end

    context 'when there is four in a row vertically' do
      it 'returns true' do
        board.instance_variable_set(:@board,
                                    [['X', 1, 2, 3], ['X', 3, 2, 1], ['X', 2, 3, 1], ['X', 4, 5, 6], [0, 6, 5, 4]])
        expect(board.four_in_a_row('X')).to be(true)
      end
    end

    context 'when there is only three in a row vertically' do
      it 'returns false' do
        board.instance_variable_set(:@board,
                                    [[1, 2, 3, 4, 5, 6, 7], [8, 9, 10, 11, 12, 13, 14], [8, 16, 17, 18, 19, 20], [8, 22, 23, 24, 25, 26, 27],
                                     [28, 29, 30, 31, 32, 33, 34]])
        expect(board.four_in_a_row('X')).to be(false)
      end
    end

    context 'when there are no matching cells in a row vertically' do
      it 'returns false' do
        board.instance_variable_set(:@board,
                                    [[1, 2, 3, 4, 5, 6, 7], [8, 9, 10, 11, 12, 13, 14], [15, 16, 17, 18, 19, 20], [21, 22, 23, 24, 25, 26, 27],
                                     [28, 29, 30, 31, 32, 33, 34]])
        expect(board.four_in_a_row('X')).to be(false)
      end
    end

    context 'when there is four in a row horizontally' do
      it 'returns true' do
        board.instance_variable_set(:@board,
                                    [[1, 3, 2, 1], %w[X X X X], [2, 2, 3, 1], [3, 4, 5, 6], [4, 6, 5, 4]])
        expect(board.four_in_a_row('X')).to be(true)
      end
    end

    context 'when there is only three in a row horizontally' do
      it 'returns false' do
        board.instance_variable_set(:@board,
                                    [[1, 2, 3, 4, 5, 6, 7], [8, 9, 10, 11, 12, 13, 14], [15, 16, 17, 18, 19, 20], [21, 22, 23, 24, 25, 26, 27],
                                     [28, 29, 30, 31, 32, 33, 34]])
        expect(board.four_in_a_row('X')).to be(false)
      end
    end

    context 'when there are no matching cells in a row horizontally' do
      it 'returns false' do
        board.instance_variable_set(:@board,
                                    [[1, 2, 3, 4, 5, 6, 7], [8, 9, 10, 11, 12, 13, 14], [15, 16, 17, 18, 19, 20], [21, 22, 23, 24, 25, 26, 27],
                                     [28, 29, 30, 31, 32, 33, 34]])
        expect(board.four_in_a_row('X')).to be(false)
      end
    end

    context 'when there is four in a row diagonally' do
      it 'returns true' do
        board.instance_variable_set(:@selected_row, 0)
        board.instance_variable_set(:@board,
                                    [['X', 1, 4, 5], [4, 'X', 2, 1], [2, 2, 'X', 1], [3, 4, 5, 'X'], [4, 6, 5, 4]])
        expect(board.four_in_a_row('X')).to be(true)
      end
    end

    context 'when there is only three in a row diagonally' do
      it 'returns false' do
        board.instance_variable_set(:@board,
                                    [[1, 2, 3, 4, 5, 6, 7], [8, 9, 10, 11, 12, 13, 14], [15, 16, 17, 18, 19, 20], [21, 22, 23, 24, 25, 26, 27],
                                     [28, 29, 30, 31, 32, 33, 34]])
        expect(board.four_in_a_row('X')).to be(false)
      end
    end

    context 'when there are no matching cells in a row diagonally' do
      it 'returns false' do
        board.instance_variable_set(:@board,
                                    [[1, 2, 3, 4, 5, 6, 7], [8, 9, 10, 11, 12, 13, 14], [15, 16, 17, 18, 19, 20], [21, 22, 23, 24, 25, 26, 27],
                                     [28, 29, 30, 31, 32, 33, 34]])
        expect(board.four_in_a_row('X')).to be(false)
      end
    end
  end
end
