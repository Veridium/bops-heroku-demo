class AccountsController < ApplicationController
  before_action :authenticate!

  def show
    @username = session[:username]
  end
end
