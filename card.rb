class Card
  attr_accessor :face_up, :face_value

  def initialize(face_up = false, face_value = 0)
    @face_up = face_up
    @face_value = face_value
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def reveal?
    @face_up == true
  end

  def to_s
    return "X" if !@face_up
    @face_value.to_s
  end

  def ==(another_card)
    @face_value == another_card.face_value
  end

end
