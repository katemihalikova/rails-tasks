class AccountController < ApplicationController
  def index
    @user = current_user
  end

  def cancel
  end
end
