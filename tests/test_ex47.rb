require "ex47/game.rb"
require "test/unit"

class TestGame < Test::Unit::TestCase

    def test_room()
        gold = Room.new("GoldRoom",
                    """This room has gold in it you can grab. There's a
                door to the north.""")
        assert_equal("GoldRoom", gold.name)
        assert_equal({}, gold.paths)
    end

    def test_room_paths()
        center = Room.new("Center", "Test room in the center.")
        north = Room.new("North", "Test room in the north.")
        south = Room.new("South", "Test room in the south.")

        center.add_paths({'north'=> north, 'south'=> south})
        assert_equal(north, center.go('north'))
        assert_equal(south, center.go('south'))

    end

    def test_map()
        corridor = Room.new("corridor", "You can go west and down a hole.")
        death = Room.new("death", "There are trees here, you can go east.")
        laser = Room.new("laser", "It's dark down here, you can go up.")

        corridor.add_paths({'shoot'=> death, 'joke'=> laser})
        death.add_paths({'follow'=> corridor})
        laser.add_paths({'fail'=> death, 'guess'=> corridor})
		#down.add_paths({'up'=> west})

        assert_equal(death, corridor.go('shoot'))
        assert_equal(laser, death.go('follow').go('joke'))
        #assert_equal(laser, laser.go('guess').go('joke'))
    assert_equal(death, laser.go('guess').go('joke'))
	
	end
end
