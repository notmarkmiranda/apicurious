require 'test_helper'

class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
	include Capybara::DSL

	def setup
		Capybara.app = Apicurious::Application
		stub_omniauth
	end

	test "logging in" do
		visit "/"
		assert_equal 200, page.status_code
		click_link "Log in with Twitter"
		assert_equal "/", current_path
		assert page.has_content?("notmarkmiranda")
		assert page.has_link?("Log Out")
	end

	def stub_omniauth
		OmniAuth.config.test_mode = true

		OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
			provider: 'twitter',
			extra: {
				raw_info: {
					uid: "1234",
					screen_name: "notmarkmiranda"
				}
			},
			credentials: {
				token: "pizza",
				secret: "secretpizza"
			}
		})

	end
end
