class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end


# <div class="overflow-x-scroll flex w-[500px] max-w-lg mx-auto mt-3 flex border-b-2 pb-6"> 


# <div><div class="w-32 h-32 "> 
# <% users.each do |user|%>    
# <% if user.image.attached? %>
#     <%= link_to image_tag(user.image,class:"flex object-cover w-32 h-32  rounded-full"),user_path(user.id);%>
# <% else%>
#     <%=  link_to image_tag("account.jpg",class:"flex object-cover w-32 h-32  rounded-full"),user_path(user.id);%>
# <% end %></div>
# <p class="mt-2 font-bold"><%= user.name %></p><% end %>
# </div>
