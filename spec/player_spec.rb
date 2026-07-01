require_relative '../lib/player'

describe Player do
  let(:player){ Player.new }
  before do
    allow(player).to receive(:puts)
    allow(player).to receive(:gets)
  end
  describe '#choose_symbol' do
    context 'when chosen number applies to the given array' do
      it 'assigns the corresponding symbol to the symbol instance variable' do
        allow(player).to receive(:gets).and_return('2')
        expect{player.choose_symbol}.to change{player.symbol}.to("\e[31m\u2b24\e[0m")
      end
    end
    context 'when chosen number does not apply to the given array' do
      it 'accepts other numbers as symbol' do
        allow(player).to receive(:gets).and_return('24')
        expect{player.choose_symbol}.to change{player.symbol}.to("24")
      end
      it 'accepts letters as symbol' do
        allow(player).to receive(:gets).and_return('X')
        expect{player.choose_symbol}.to change{player.symbol}.to("X")
      end
      it 'accepts other unicode symbols as symbol' do
        allow(player).to receive(:gets).and_return("\u232c")
        expect{player.choose_symbol}.to change{player.symbol}.to("\u232c")
      end
    end
  end

  describe "#check_choice" do
    before do
      allow(player).to receive(:choose_column)
    end
    context 'when choice is in an in-range number and not full' do
      let(:board) { Array.new(3, Array.new(3)) }
      it 'assigns choice to column_choice' do
        chosen_column = 1
        expect{player.check_choice(chosen_column, board)}.to change{player.chosen_column}.to(1)
      end
    end
    context 'when choice is out of range' do
      let(:board) { Array.new(3, Array.new(3)) }
      it 'returns false' do
        chosen_column = 9
        expect(player.check_choice(chosen_column, board)).to eq(false)
      end
    end
    context 'when choice is NaN' do
      let(:board) { Array.new(3, Array.new(3)) }
      it 'returns false' do
        chosen_column = 'A'.to_i - 1
        expect(player.check_choice(chosen_column, board)).to eq(false)
      end
    end
    context 'when column is full' do
      let(:board) {[[nil, nil, 1], [nil, nil, 1], [nil, nil, 1]]}
      it 'returns false' do
        chosen_column = 2
        expect(player.check_choice(chosen_column, board)).to eq(false)
      end
    end
  end
end