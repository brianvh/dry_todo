# Order takes a required clause and optional collection
# It looks for `order_by` in the `input` which would be a field to order by
# It will also look for the optional `order_direction`, defaulting to `asc`, to build the clause.
# `clause` is any valid input to AR method `order` and if provided will be used if the `order_by` key is not found
# `collection` is a symbol key into `input` where the collection to order is found
#              defaults to `:collection` if not provided
#

module Components
  module Common
    module Order
      def self.[] clause: nil, collection: :collection
        -> (input) {
          if input[:order_by]
            clause = { input[:order_by].to_s.underscore => (input[:order_direction] || :asc) }
          end
          if input[collection].present? && clause.present?
            input[collection] = input[collection].order(clause)
          end
          Right input
        }
      end
    end
  end
end
