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
end