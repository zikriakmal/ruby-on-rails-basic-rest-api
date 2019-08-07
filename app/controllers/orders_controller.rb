class OrdersController < ApplicationController
    before_action :set_order, only: [ :show]
    before_action :set_user, only: [:create, :index]
    def index
        order = @user.orders.all.paginate(page: params[:page], per_page: params[:per_page])
        render json: { status: :SUCCESS, data: ActiveModelSerializers::SerializableResource.new(order, each_serializer: OrderSerializer, error: nil) }, status: :ok
    end

    def create
        if params.has_key?(:user,:product)
            @order = @user.orders.create(order_param)
            if @order.save
                render json: {result: true, orders: @order}, status: :created
            else
                render json: {result: false, orders: @order.errors}, status: :unprocessable_entity
            end
        else
            render json: {result: true, message:"Parameter tidak sesuai"}, status: :ok
        end
    end

    def show
        #render json: {result: true, user: @order}
        json_response(Response::SUCCESS, OrderSerializer.new(@order),nil, :ok)
    end

    private
    def order_param
        params.permit(:user, :product)
    end

    def set_order
        @order = Order.find(params[:id])
    end

    def set_user
        @user = @current_user
    end
end
