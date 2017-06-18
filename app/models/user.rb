class User < ApplicationRecord
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  has_and_belongs_to_many :roles

  scope :user_list, -> {where(roles: Role.where(hide: false))}

  validates_presence_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_uniqueness_of :email

  def users_list

  end
  def roles_list
    self.roles.where(hide: true)
  end

  def create_roles(role_ids)
      if role_ids
        role_ids = role_ids.compact.reject { |h| h == "" }.collect{|d| d.to_i}
        user_role_ids = self.roles.collect(&:id)
        unselected_role_ids = user_role_ids - role_ids
        self.roles.where(id: unselected_role_ids).destroy_all
        role_ids.each do |role_id|
          self.roles << Role.find(role_id)
        end
      end
    end
end
