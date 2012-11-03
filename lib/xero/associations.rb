module Xero
  module Associations
    extend ActiveSupport::Concern

    included do
      include Xero::Associations::BelongsTo
      include Xero::Associations::HasMany
      include Xero::Associations::HasOne
    end
  end
end
