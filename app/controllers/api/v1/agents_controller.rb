module Api
  module V1
    class AgentsController < BaseController
      before_action :set_agent, only: [ :update, :destroy ]

      def index
        @agents = @current_user.lab.agents.includes(:address).recently_updated
        render json: { agents: @agents, message: "Agents fetched successfully" }, status: :ok
      end

      def create
        agent = @current_user.lab.agents.build(agent_params)

        if agent.save
          render json: { agent:, message: "Agent created successfully" }, status: :created
        else
          render json: {
            errors: agent.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        if @agent.update(agent_params)
          render json: { agent: @agent, message: "Agent updated successfully" }, status: :ok
        else
          render json: { errors: @agent.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @agent.destroy
          render json: { message: "Agent deleted successfully" }, status: :ok
        else
          render json: { errors: @agent.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_agent
        @agent = Agent.find_by(params[:id])
      end

      def agent_params
        params.require(:agent).permit(:name, :phone, :email, address_attributes: [ :street, :city, :state, :zip ])
      end
    end
  end
end
