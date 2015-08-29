require_relative 'player'
require_relative 'treasure_trove'

module StudioGame

  describe Player do
    before do
      @initial_health = 150
      @player = Player.new('larry', @initial_health)
    end

    it 'has a capitalized name' do
      expect(@player.name).to eql('Larry')
    end

    it 'has an initial health' do
      expect(@player.health).to eql(150)
    end

    it 'has a string representation' do
      expect(@player.to_s).to eql( "I'm Larry with a health = 150, points = 0, and a score = 150.")
    end

    it 'computes a score as the sum of its health and points' do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.to_s).to eql( "I'm Larry with a health = 150, points = 100, and a score = 250.")
    end

    it 'increases health by 15 when w00ted' do
      @player.w00t
      expect(@player.health).to eql(@initial_health += 15)
    end

    it 'decreases health by 10 when blammed' do
      @player.blam
      expect(@player.health).to eql(@initial_health - 10)
    end

    it 'computes points as the sum of all treasure points' do
      expect(@player.points).to eql(0)

      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.points).to eql(50)

      @player.found_treasure(Treasure.new(:crowbar, 400))

      expect(@player.points).to eql(450)

      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.points).to eql(500)
    end

    it 'yields each found treasure and its total points' do
      @player.found_treasure(Treasure.new(:skillet, 100))
      @player.found_treasure(Treasure.new(:skillet, 100))
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))

      yielded = []
      @player.each_found_treasure do |treasure|
        yielded << treasure
      end

      expect(yielded).to eql([Treasure.new(:skillet, 200), Treasure.new(:hammer, 50), Treasure.new(:bottle, 25)])
    end

    it 'can be created from a CSV string' do
      player = Player.from_csv('larry,150')

      expect(player.name).to eql('Larry')
      expect(player.health).to eql(150)
    end

    context 'player has initial health of 150' do
      before { @player = Player.new('larry', 150) }

      it 'should be strong' do
        expect(@player.strong?).to be_truthy
      end
    end

    context 'player has an initial health of 100' do
      before { @player = Player.new('larry', 100) }

      it 'should not be strong' do
        expect(@player.strong?).to be_falsey
      end
    end

    context 'in a collection of players' do
      before do
        @player1 = Player.new("moe", 100)
        @player2 = Player.new("larry", 200)
        @player3 = Player.new("curly", 300)

        @players = [@player1, @player2, @player3]
      end

      it 'is sorted by decreasing score' do
        expect(@players.sort).to eql([@player3, @player2, @player1])
      end
    end
  end

end

