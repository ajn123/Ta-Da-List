# frozen_string_literal: true

# Api controller for items
class Api::ItemsController < Api::ApiController
  def index
    render status: 200, json: {
      items: List.find(params[:list_id]).items
    }.to_json
  end

  def create
    item = List.find(params[:list_id]).items.build(item_params)
    if item.save
      render status: :ok, json: { message: 'Successfully created ' }
    else
      render status: :unprocessable_entity, json: {
        message: item.errors.full_messages
      }.to_json
    end
  end

  def show
    List.find(params[:list_id])
  end

  private

  def item_params
    params.require(:item).permit(:title, :content, :due_date)
  end
end
