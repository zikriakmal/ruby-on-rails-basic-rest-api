class ProductsController < ApplicationController


    def index
        @products = Product.all.paginate(page: params[:page], per_page: params[:per_page])
        render json: { status: :SUCCESS, data: ActiveModelSerializers::SerializableResource.new(@products, each_serializer: ProductSerializer, error: nil) }, status: :ok
        # json_response(Response::SUCCESS, ActiveModelSerializers::SerializableResource.new(products, each_serializer: ProductSerializer ), nil, :ok)       
    end
    

    def create
        if params.has_key?(:kode)
            @product = @user.products.create(product_param)
            if @product.save
                render json: {result: true, products: @product}, status: :created
            else
                render json: {result: false, products: @product.errors}, status: :unprocessable_entity
            end
        else
            render json: {result: true, message:"Parameter tidak sesuai"}, status: :ok
        end
    end

    def show
        #render json: {result: true, user: @product}
        json_response(Response::SUCCESS, productSerializer.new(@product),nil, :ok)
    end

    private
    def product_param
        params.permit(:nama, :kode,:jumlah ,:user)
    end

    def set_product
        @product = product.find(params[:id])
    end

    def set_user
        @user = @current_user
    end

end
