class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  before_create :confirm_participant
  
  after_create_commit do
    update_parent_room
    broadcast_append_to room
    # message_notif
  end

  def confirm_participant
      return unless room.is_private
      is_participant = Participant.where(user_id: user.id, room_id: room.id).first
      throw :abort unless is_participant
  end

  def update_parent_room
    room.update(last_message_at: Time.now)
  end

  def message_notif
    room.participants.each do 
      flash.alert = "Message recieved"
    end

    

  end
end
