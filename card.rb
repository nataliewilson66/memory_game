class Card

  attr_reader :face_value, :face_up

  def initialize(face_value = nil)
    @face_value = face_value
    @face_up = false
  end

  def display_card 
    if @face_up
      return face_value
    end
    ""
  end

  def hide
    @face_up = false
    face_value
  end

  def reveal
    @face_up = true
    face_value
  end

  def ==(other_card)
    if self.face_value == other_card.face_value
        return true
    end
    false
  end

  def to_s
    
  end


end