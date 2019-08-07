class UsersController < ApplicationController



    #before_action :set_user, only: [:show, :update, :delete, :create]
    #skip_before_action :authenticate_request, only: [:login,:create,:show]

    def index
        @users = User.all.paginate(page: params[:page], per_page: params[:per_page])
        #render json: {result: true, users: @users}, status: :ok   
        # json_response(Response::SUCCESS, ActiveModelSerializers::SerializableResource.new(users, each_serializer: UserLoginSerializer),nil ,:ok)     
        render json: { status: :SUCCESS, data: ActiveModelSerializers::SerializableResource.new(@users, each_serializer: UserLoginSerializer, error: nil) }, status: :ok
       
    end
    
    def show
        render json: {result: true, user: @user}
        json_response(Response::SUCCESS, UserLoginSerializer.new(@user),nil, :ok)
    end

    def update
        if @user.update(user_param)
            render json: {result: true, msg:"Update Success"}
        else
            render json: {result: false, msg:"Update Faile"}
        end 
    end

    
    def create
        if params.has_key?(:username)
            @user = User.create(user_param)
            if @user.save
                # PushNotificationWorker.perform_async(user.id)
                render json: {result: true, users: @user}, status: :created
            else
                render json: {result: false, users: @user.errors}, status: :unprocessable_entity
            end
        else
            render json: {result: true, message:"Parameter tidak sesuai"}, status: :ok
        end
    end

    def login

        if params.key?(:username) && params.key?(:password)
            username = params[:username]
            password = params[:password]
            if User.where(:username => username, :password => password).exists?
                @user = User.where(:username => username).first
                token = authenticate(@user.username, @user.id)
                json_response_login(Response::SUCCESS, UserLoginSerializer.new(@user), nil, token, :ok)
            else
                json_response_login(Response::FAILED, nil, "password atau username salah", nil, :unauthorized)
            end 
        
        else
           json_response_login(Response::Failed, nil, "parameter yang dikirim tidak cocok", nil, :unauthorized)
        end
    end





    def authenticate(username, id)
        command = AuthenticateUser.call(username, id)
        if command.success?
            #user = User.save_api_key(username, id, command.result)
            api_key = command.result
            return api_key
        else
            json_response_login(Response::FAILED, nil, {code: 802, message:"#{command.errors}"}, nil, :unauthorized)
            return
        end
    end    



    private
    def user_param
        params.permit(:username, :name, :password)
    end

    def set_user
        @user = User.friendly.find(params[:id])
    end

    def delete
        if @user.destroy
            render json: {result: true, msg: "Delete Success"}
        else
            render json: {result: false, msg: "Delete Failed"}
        end
    end




end
