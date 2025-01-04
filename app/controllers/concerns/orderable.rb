module Orderable
  extend ActiveSupport::Concern

  private

  def order_correct?
    order_params.include?(order_param) && order_directions.include?(order_direction)
  end

  def order_param
    params[:order_param]&.to_sym
  end

  def order_direction
    params[:order_direction]&.upcase&.to_sym
  end

  # You must override this method in controller
  def order_params
    []
  end

  def order_directions
    %i[ASC DESC]
  end
end
