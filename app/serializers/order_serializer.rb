class OrderSerializer < ActiveModel::Serializer
    attributes :id, :user, :product  
  
    def user
      profile = User.find(object.user_id)
      UserLoginSerializer.new(profile)
    end

    def product
        barang = Product.find(object.product_id)
        ProductSerializer.new(barang)
    end
  end
  