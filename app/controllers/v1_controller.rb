class V1Controller < ApplicationController
  private

  def authentications_scope
    Authentication.regular
  end
end
