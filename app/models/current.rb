class Current < ActiveSupport::CurrentAttributes
  attribute :authentication, :user

  def authentication=(value)
    super

    self.user = value&.user
  end
end
