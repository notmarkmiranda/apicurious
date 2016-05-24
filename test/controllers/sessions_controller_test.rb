require "test_helper"

#class SessionsControllerTest < ActionController::TestCase
#	include Capybara::DSL
#
#	def setup
#		Capybara.app = Apicurious::Application
#		stub_omniauth
#	end
#
#	test "#create" do
#		get :create
#		assert_redirected_to root_path
#	end
#
#	def stub_omniauth
#		OmniAuth.config.test_mode = true
#
#		OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
#			provider: 'twitter',
#			extra: {
#				raw_info: {
#					uid: "1234",
#					screen_name: "notmarkmiranda"
#				}
#			},
#			credentials: {
#				token: "pizza",
#				secret: "secretpizza"
#			}
#		})
#	end
#end
