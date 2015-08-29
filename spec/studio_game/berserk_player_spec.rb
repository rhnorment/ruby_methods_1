require 'studio_game/berserk_player'

module StudioGame

  describe BerserkPlayer do
    before do
      @initial_health = 50
      @player = BerserkPlayer.new('berserker', @initial_health)
    end

    it 'does not go berserk when w00ted up to 5 times' do
      5.times { @player.w00t }

      expect(@player.berserk?).to be_falsey
    end

    it 'goes berserk when w00ted more than 5 times' do
      6.times { @player.w00t }

      expect(@player.berserk?).to be_truthy
    end

    it 'gets w00ted instead of blammed when it is in berserk mode' do
      6.times { @player.w00t }
      2.times { @player.blam }

      expect(@player.health).to eql(@initial_health + (8 * 15))
    end
  end

end

