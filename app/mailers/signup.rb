class Signup < ActionMailer::Base
	default from: 'no-replay@colcho.net'
	def confirm_email(user)
		@user = user
		#link temporario
		@confirmation_link = root_url

		mail({
			to: user.email,
			bcc: ['sign ups <signups@colcho.net>'],
			subject: I18n.t('signup.confirm_email.subject')
		})
	end
end