# frozen_string_literal: true

require "test_helper"

class TestInfix < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Infix::VERSION
  end

  class Bird
    include Infix
  end

  def test_a_class_configure
    b = Bird.new
    b.infix do
      type      :european
      carrying  "coconut"
      topspeed  24

      film_references do
        monty_python  true
        star_wars     "no"
      end
    end

    assert_equal :european, b.infix.type
    assert_equal "coconut", b.infix.carrying
    assert_equal 24, b.infix.topspeed
    assert_equal true, b.infix.film_references.monty_python
    assert_equal "no", b.infix.film_references.star_wars
  end
end
