module Api
  module V1
    class AgentsController < BaseController
      before_action :set_agent, only: [ :update, :destroy ]

      def index
        @agents = @current_user.lab.agents.includes(:address).recently_updated
        render json: {
          agents: @agents,
          message: "Agents Associated with lab"
        }
      end

      def create
        agent = @current_user.lab.agents.build(agent_params)

        if agent.save
          render json: {
            agent:,
            message: "Agent Created Successfully"
          }, status: :created

        else
          render json: {
            message: agent.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        if @agent.update(agent_params)
          render json: {
            agent:,
            message: "Agent Updated Successfully"
          }
        else
          render json: {
            message: agent.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def destroy
        @agent.destroy
        render json: {
          message: "Agent deleted"
        }
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
