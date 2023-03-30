class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :contact_number, presence: true, format: { with: /\A\+91\d{10}\z/, message: "must be a Indian phone number" }


         has_many :interests

         

         followability

         def unfollow(user)
            followerable_relationships.where(followable_id: user.id).destroy_all
         end

         def follow_request_accepted_by(record)
            puts(record,"accepted the request")
         end

         def age
            now = Time.now.utc.to_date
            dob = self.date_of_birth.to_date
            age_in_years = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
            age_in_years
          end

         has_one_attached :image, :dependent => :destroy
         # follow_request_accepted_by_someone :follow_request_accepted_by
end
