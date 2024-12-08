module Paginable
  extend ActiveSupport::Concern
  include Pagy::Backend

  private

  def paginate(collection)
    pagy, records = pagy(collection)

    Rails.logger.info pagy.to_json

    pagination = {
      count: pagy.count,
      page: pagy.page,
      pages: pagy.last,
      limit: pagy.limit
    }

    [ pagination, records ]
  end
end
