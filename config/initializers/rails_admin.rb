require "nested_form/engine"
require "nested_form/builder_mixin"

RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  RailsAdmin.config do |config|
    config.authenticate_with do
      warden.authenticate! scope: :admin
    end
    config.current_user_method(&:current_admin)
  end

  config.model 'User' do
    list do
      field :id
      field :email
      field :full_name
      field :created_at
    end

    show do
      exclude_fields :jti
    end

    edit do
      exclude_fields :jti, :password, :password_confirmation, :reset_password_sent_at, :remember_created_at, :orders
    end
  end

  config.model 'Item' do
    list do
      field :id
      field :name
      field :price
      field :stock
      field :updated_at
    end
  end

  config.model 'Cart' do
    list do
      field :id
      field :user
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :user
      field :items
      field :resume_cart
      field :total
      field :created_at
      field :updated_at
    end
  end

  config.model 'Order' do
    list do
      field :id
      field :user
      field :status
      field :order_items
      field :items
      field :created_at
    end

    show do
      field :id
      field :user
      field :status
      field :resume_order
      field :total
      field :created_at
      field :updated_at
    end

    edit do
      exclude_fields :user
    end
  end

# Hide ActiveStorage models ---------------------
  config.model 'ActiveStorage::Blob' do
    visible false
  end

  config.model 'ActiveStorage::Attachment' do
    visible false
  end

  config.model 'ActiveStorage::VariantRecord' do
    visible false
  end
  # ---------------------------------------------

  config.excluded_models = [OrderItem, CartItem]

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

end
