class Role < ApplicationRecord
	has_and_belongs_to_many :users

	def self.hide_roles(role_ids)
		seleted_roles = Role.where(id: role_ids).update_all(hide: true)
		unselected_roles = Role.where.not(id: role_ids).update_all(hide: false)
	end
end