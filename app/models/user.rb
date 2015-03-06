class User < ActiveRecord::Base
	#validates é uma class macro

	EMAIL_REGEXP = /\A[^@]+@([\.]+\.)+[^@\.]+\z/
	#validates_presence_of :email, :full_name, :location, :password
	validates_presence_of :email, :full_name, :location
	#validates_confirmation_of :password
	validates_length_of :bio, minimum: 5, allow_blank: false
	validates_uniqueness_of :email

	#validacao por expressao regular
	def email_format
		errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
	end

	has_secure_password

	before_create do |user|
		user.confirmation_token = SecureRandom.urlsafe_base64
	end

	def confirm!
		return if confirmed?
		self.confirmed_at = Time.current
		self.confirmation_token = ''
		save!
	end

	def confirmed?
		confirmed_at.present?
	end

end
