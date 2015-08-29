require_relative 'clumsy_player'

module StudioGame

  describe ClumsyPlayer do
    before { @player = ClumsyPlayer.new('klutz') }

    it 'only gets half the points for each treasure' do
      expect(@player.points).to eql(0)

      hammer = Treasure.new(:hammer, 50)
      @player.found_treasure(hammer)
      @player.found_treasure(hammer)
      @player.found_treasure(hammer)

      expect(@player.points).to eql(75)

      crowbar = Treasure.new(:crowbar, 400)
      @player.found_treasure(crowbar)

      expect(@player.points).to eql(275)

      yielded = []
      @player.each_found_treasure do |treasure|
        yielded << treasure
      end

      expect(yielded).to eql([Treasure.new(:hammer, 75), Treasure.new(:crowbar, 200)])
    end
  end

end

