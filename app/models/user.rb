class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


         scope :all_except, ->(user){where.not(id: user)}
         after_create_commit {broadcast_append_to "users"}
         has_many :messages, dependent: :destroy

         validates :contact_number, presence: true, format: { with: /\A\+91\d{10}\z/, message: "must be a Indian phone number" }
         # validates :city, presence: true

         # validate :skip_email_validation_if_name_is_blank

         def skip_email_validation_if_city_is_blank
           if city.blank?
             self.email = nil
             self.password = nil
             self.password_confirmation = nil
             self.contact_number = nil
             self.name = nil
           end
         end


         has_many :interests, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :likes, dependent: :destroy

         

         followability

         def unfollow(user)
            followerable_relationships.where(followable_id: user.id).destroy_all
         end

         def self.ransackable_attributes(auth_object = nil)
            [ "email","name"]
          end

         
         def self.states
            CS.states(:IN)
         end
      
         def self.cities
            CS.cities(state, :IN ) || []
         end


         # def follow_request_accepted_by_someone(record);
         #    puts(record)
         # end


         def age
            now = Time.now.utc.to_date
            dob = self.date_of_birth.to_date
            age_in_years = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
            age_in_years
          end

         has_one_attached :image, dependent: :destroy
         # follow_request_accepted_by_someone :follow_request_accepted_by
end
