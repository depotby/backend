module Orderable
  extend ActiveSupport::Concern

  private

  def ordering_correct?
    orderable_params.include?(order_param) && order_directions.include?(order_direction)
  end

  def order_param
    params[:order_param]&.to_sym
  end

  def order_direction
    params[:order_direction]&.downcase&.to_sym
  end

  # You must override this method in controller
  def order_params
    []
  end

  def order_directions
    %i[asc desc]
  end
end
