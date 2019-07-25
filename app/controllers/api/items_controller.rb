# frozen_string_literal: true

# Api controller for items
class Api::ItemsController < Api::ApiController
  before_action :find_list

  def index
    render status: 200, json: {
      items: @list.items
    }.to_json
  end

  def create
    item = @list.items.build(item_params)
    if item.save
      render status: :ok, json: { message: 'Successfully created ' }
    else
      render status: :unprocessable_entity, json: {
        message: item.errors.full_messages
      }.to_json
    end
  end

  def show; end

  def destroy; end

  private

  def item_params
    params.require(:item).permit(:title, :content, :due_date)
  end

  def find_list
    @list = List.find(params[:list_id])
  end
end
